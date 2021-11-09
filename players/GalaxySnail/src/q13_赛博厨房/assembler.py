from __future__ import annotations

from dataclasses import dataclass

import compiler
from compiler import (
    Point, CodeIndex,
    NoArgCode, OneArgCode, TwoArgsCode, CommandCode
)
from utils import assert_never
from code_gen import CodeGenerator


import typing
from typing import Tuple, Iterable
from typing import BinaryIO, Literal, Final
if typing.TYPE_CHECKING:
    from _protos import File as FileProto


# 跳转表的写法没法从 mypy 的穷尽性检查中受益，所以放弃
# CodeHandler = Callable[[CodeGenerator, CommandCode], None]

# mypy 的穷尽性检查甚至还不足以检查包含枚举的元组这样稍微复杂的情况，
# 因此只能检查枚举是否穷尽，而无法检查枚举是否正确对应了参数 args 的类型


@dataclass
class Assembler:
    code_gen: CodeGenerator

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        self.close()

    def close(self):
        self.code_gen.close()

    @classmethod
    def from_file(
        cls,
        file: FileProto,
        use_text_io: bool,
        *,
        close_when_exit: bool = False
    ) -> "Assembler":
        code_gen = CodeGenerator(file, use_text_io,
                                 close_when_exit=close_when_exit)
        return cls(code_gen)

    def _gen_code(self, code: CommandCode) -> None:
        code_index: CodeIndex
        args: tuple
        code_index, args = code
        g: CodeGenerator = self.code_gen

        if code_index is CodeIndex.NOP:
            pass
        elif code_index is CodeIndex.UP:
            g.up(*args)
        elif code_index is CodeIndex.DOWN:
            g.down(*args)
        elif code_index is CodeIndex.LEFT:
            g.left(*args)
        elif code_index is CodeIndex.RIGHT:
            g.right(*args)
        elif code_index is CodeIndex.DROP:
            g.drop(*args)
        elif code_index is CodeIndex.GET:
            g.get(*args)
        elif code_index is CodeIndex.GOTO:
            g.goto(*args)
        elif code_index is CodeIndex.DROP_PLATE:
            g.drop_plate()
        elif code_index is CodeIndex.GET_PLATE:
            g.get_plate()
        elif code_index is CodeIndex.STAND_STILL:
            g.stand_still()
        elif code_index is CodeIndex.IF_GE_AND_GOTO:
            g.if_ge_and_goto(*args)
        else:
            # 穷尽性检查
            assert_never(code_index)

    def __call__(self, codes: Iterable[CommandCode]) -> None:
        for code in codes:
            self._gen_code(code)

