from __future__ import annotations

import unittest
from io import BytesIO, StringIO

from code_gen import CodeGenerator
import level_0
import level_1

from typing import List
from typing import Callable

class TestCodeGeneratorLeveln(unittest.TestCase):
    expected_str: List[str] = [(
        "向右 1 步\n"
        "拿起 1 个物品\n"
        "向下 1 步\n"
        "向左 1 步\n"
        "放下 1 个物品\n"
        "向右 2 步\n"
        "向上 1 步\n"
        "拿起 1 个物品\n"
        "向下 1 步\n"
        "向左 2 步\n"
        "放下 1 个物品\n"
    ), (
        "向右 1 步\n"
        "拿起 73 个物品\n"
        "向下 1 步\n"
        "向左 1 步\n"
        "放下 1 个物品\n"
        "如果手上的物品大于等于 1 向上跳转 1 行\n"
    )]
    gen_code: List[Callable[[CodeGenerator], None]] = [
        level_0.gen_code,
        level_1.gen_code,
    ]

    def _test_binary_file(self, gen_code, expected_str: str) -> None:
        bio = BytesIO()
        with CodeGenerator(bio, use_text_io=False) as g:
            gen_code(g)
        self.assertEqual(
            bio.getvalue().decode("utf-8"),
            expected_str
        )

    def _test_text_file(self, gen_code, expected_str: str) -> None:
        sio = StringIO()
        with CodeGenerator(sio, use_text_io=True) as g:
            gen_code(g)
        self.assertEqual(
            sio.getvalue(),
            expected_str
        )

    def test_binary_file(self) -> None:
        for level, (gen_code, expected) in enumerate(zip(
            self.gen_code,
            self.expected_str,
        )):
            with self.subTest(
                level=level,
                gen_code=gen_code.__qualname__,
                expected_str=expected
            ):
                self._test_binary_file(gen_code, expected)

    def test_text_file(self) -> None:
        for level, (gen_code, excepted) in enumerate(zip(
            self.gen_code,
            self.expected_str,
        )):
            with self.subTest(
                level=level,
                gen_code=gen_code.__qualname__,
                expected_str=excepted,
            ):
                self._test_text_file(gen_code, excepted)


