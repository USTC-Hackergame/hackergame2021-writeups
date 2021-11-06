import sys
from io import StringIO
from hashlib import sha256
import subprocess as sp
from pathlib import Path

import tqdm  # type: ignore

from compiler import (
    CommandCode, MoveHelper, move,
    get, drop, get_plate, drop_plate,
    if_lt_elif_lt_else, while_lt, do_while_ge,
)
from assembler import Assembler
from code_gen import CodeGenerator

from typing import List, Dict, Iterable, Sequence


def gen_opcode(mh: MoveHelper) -> Iterable[CommandCode]:
    for x in range(6):
        yield from mh.move_to_do_sth_and_return(
            (x, 0),
            get(1),
        )
        yield from drop(1)


def calc_hash(programs: List[str]) -> str:
    hashes = [sha256(p.strip().encode("utf-8")).hexdigest() \
              for p in programs]
    h = sha256("\n".join(hashes).encode("utf-8")).hexdigest()
    return h


def main():
    codes = gen_opcode(MoveHelper(pos=(-1, 0)))
    sio = StringIO()
    with Assembler.from_file(sio, use_text_io=True,
                             close_when_exit=True) as asm:
        asm(codes)
        program = sio.getvalue()
        # 不要从终端复制输出（会复制多出来空格，非常坑爹）

    try:
        start = int(sys.argv[1])
    except (ValueError, IndexError):
        start = 0

    for i in tqdm.tqdm(range(32**6//4*7 + 40_000_000, 32**6 * 2)):
        programs = [program, f"向右 {i} 步"]
        seed = calc_hash(programs)
        print(f"{i}|{seed}")

        # awswer:
        # if i == 1919726866:
        #     print(f"{i}|{seed}", file=sys.stderr)
        #     print(programs, file=sys.stderr, flush=True)


if __name__ == "__main__":
    main()

