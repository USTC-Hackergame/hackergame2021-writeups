import re
import json
import httpx

from typing import List
from typing import Optional, cast


def handle_response_json(res: dict) -> Optional[dict]:
    if res["status"] == "error":
        if match := re.search(
            r"Seed is not correct, should be ([0-9a-f]+)\.",
            res["message"]
        ):
            res["seed"] = match.group(1)
            return res

        if match := re.search(
            r"No win. The recipe should be (\[(\d+\,)*\d+\])\.",
            res["message"]
        ):
            res["recipe"] = json.loads(match.group(1))
            return res

    return None


class CyberCookApi:
    url: str
    level: int
    tolen: str
    client: httpx.AsyncClient

    def __init__(self, url: str, level: int, token: str):
        self.url = url
        self.level = level
        self.token = token
        self.client = httpx.AsyncClient()

    async def __aenter__(self) -> "CyberCookApi":
        return self

    async def __aexit__(self, exc_type, exc_value, traceback) -> bool:
        await self.aclose()
        return False

    async def aclose(self) -> None:
        await self.client.aclose()

    async def verify(
        self,
        programs: List[str],
        executions: List[int],
        seed: str
    ) -> dict:
        req_json = {
            "level": self.level,
            "token": self.token,
            "programs": programs,
            "executions": executions,
            "seed": seed,
        }
        r = await self.client.post(self.url, json=req_json)
        try:
            res_json: dict = r.json()
        except Exception as e:
            raise ValueError(r, r.text) from e

        if handled_json := handle_response_json(res_json.copy()):
            return handled_json

        raise ValueError(r, res_json)


