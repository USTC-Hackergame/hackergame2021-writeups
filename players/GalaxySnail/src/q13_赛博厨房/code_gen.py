from __future__ import annotations

from dataclasses import dataclass, InitVar

from utils import require_positive as _require_positive
from utils import UnreachableError


import typing
from typing import Generic, TypeVar, cast
if typing.TYPE_CHECKING:
    from _typeshed import ReadableBuffer
    from _protos import File as FileProto


__all__ = ["CodeGenerator"]

T_AnyStr = TypeVar("T_AnyStr", str, "ReadableBuffer")


@dataclass
class CodeGenerator(Generic[T_AnyStr]):
    file: FileProto[T_AnyStr]
    use_text_io: InitVar[bool] = False
    close_when_exit: bool = False  # kwonly

    def __post_init__(self, use_text_io: bool) -> None:
        # use `setattr` instead of assignment to make mypy happy, see:
        # https://github.com/python/mypy/issues/2427#issuecomment-384229898
        if use_text_io:
            setattr(self, "_write", self._write_to_text_io)
        else:
            setattr(self, "_write", self._write_to_binary_io)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        self.close()

    def close(self):
        self.file.flush()
        if self.close_when_exit:
            self.file.close()

    def _write(self, data: str) -> None:
        """此方法在 __post_init__ 方法中初始化"""
        raise UnreachableError(CodeGenerator._write.__doc__)

    def _write_to_text_io(self, data: str):
        # XXX mypy can't check this, we cast it here
        file = cast("FileProto[str]", self.file)
        length = len(data)
        writed = 0
        while length != writed:
            writed += file.write(data[writed:])

    def _write_to_binary_io(self, data: str):
        # XXX mypy can't check this, we cast it here
        bio = cast("FileProto[ReadableBuffer]", self.file)
        b = memoryview(data.encode("utf-8"))
        del data
        length = len(b)
        writed = 0
        while length != writed:
            writed += bio.write(b[writed:])

    def _up(self, steps: int):
        self._write(f"向上 {steps} 步\n")

    def up(self, steps: int):
        _require_positive(steps)
        self._up(steps)

    def stand_still(self):
        self._up(0)

    def down(self, steps: int):
        _require_positive(steps)
        self._write(f"向下 {steps} 步\n")

    def left(self, steps: int):
        _require_positive(steps)
        self._write(f"向左 {steps} 步\n")

    def right(self, steps: int):
        _require_positive(steps)
        self._write(f"向右 {steps} 步\n")

    def drop(self, items: int):
        _require_positive(items)
        self._write(f"放下 {items} 个物品\n")

    def get(self, items: int):
        _require_positive(items)
        self._write(f"拿起 {items} 个物品\n")

    def drop_plate(self):
        self._write("放下盘子\n")

    def get_plate(self):
        self._write("拿起盘子\n")

    def _if_ge_and_goto(self, items: int, rel_lineno: int):
        if rel_lineno == 0:
            raise ValueError("`rel_lineno` requires a non-zero interger.")

        self._write(f"如果手上的物品大于等于 {items} "
                    f"向{'上' if rel_lineno < 0 else '下'}"
                    f"跳转 {abs(rel_lineno)} 行\n")

    def if_ge_and_goto(self, items: int, rel_lineno: int):
        if items <= 0:
            raise ValueError(
                f"`items` requires a positive integer, but got {items}.")

        self._if_ge_and_goto(items, rel_lineno)

    def goto(self, rel_lineno: int):
        self._if_ge_and_goto(0, rel_lineno)

