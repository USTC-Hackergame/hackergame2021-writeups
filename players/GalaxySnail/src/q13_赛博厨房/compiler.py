# requires python3.8 or later
from enum import IntEnum, auto, unique
from dataclasses import dataclass
from itertools import chain

from typing import (
    List,
    Tuple,
    Union,
    Iterable,
)
from typing import (
    Final,
    Literal,
)

from utils import require_positive as _require_positive

__all__ = (
    "Point",
    "CodeIndex", "NoArgCode", "OneArgCode", "TwoArgsCode", "CommandCode",
    "move_to", "move_to_do_sth_and_return", "move_to_do_sth_and_move_to",
    "drop", "get", "drop_plate", "get_plate",
    "Condition", "IfCondition", "ElifCondition", "if_lt_elif_lt_else",
    "while_lt", "do_while_ge", "loop_forever",
    "MoveHelper"
)

Point = Tuple[int, int]


@unique
class CodeIndex(IntEnum):
    """所有的操作码（opcode）"""
    NOP   = 0
    UP    = auto()
    DOWN  = auto()
    LEFT  = auto()
    RIGHT = auto()
    DROP  = auto()
    GET   = auto()
    GOTO  = auto()
    DROP_PLATE = auto()
    GET_PLATE  = auto()
    STAND_STILL = auto()
    IF_GE_AND_GOTO = auto()


NoArgCodeIndex = Literal[
    CodeIndex.NOP,
    CodeIndex.DROP_PLATE,
    CodeIndex.GET_PLATE,
    CodeIndex.STAND_STILL,
]
OneArgCodeIndex = Literal[
    CodeIndex.UP,
    CodeIndex.DOWN,
    CodeIndex.LEFT,
    CodeIndex.RIGHT,
    CodeIndex.DROP,
    CodeIndex.GET,
    CodeIndex.GOTO,
]
TwoArgsCodeIndex = Literal[
    CodeIndex.IF_GE_AND_GOTO,
]

NoArgCode = Tuple[NoArgCodeIndex, Tuple[()]]
OneArgCode = Tuple[OneArgCodeIndex, Tuple[int]]
TwoArgsCode = Tuple[TwoArgsCodeIndex, Tuple[int, int]]

CommandCode = Union[NoArgCode, OneArgCode, TwoArgsCode]


# TODO 重新组织代码，把底层位置移动、MoveHelper、以及流程控制分开到不同模块
def move_x(x: int) -> OneArgCode:
    """right is positive and left is negitive"""
    return (
        CodeIndex.LEFT if x < 0 else CodeIndex.RIGHT,
        (abs(x),),
    )

def move_y(y: int) -> OneArgCode:
    """down is positive and up is negitive"""
    return (
        CodeIndex.UP if y < 0 else CodeIndex.DOWN,
        (abs(y),),
    )

def move(delta_x: int = 0, delta_y: int = 0) -> Iterable[OneArgCode]:
    if delta_x:
        yield move_x(delta_x)
    if delta_y:
        yield move_y(delta_y)


def move_to(
    start_point: Point,
    target_point: Point
) -> Iterable[OneArgCode]:
    delta_x = target_point[0] - start_point[0]
    delta_y = target_point[1] - start_point[1]
    return move(delta_x, delta_y)


def move_to_do_sth_and_return(
    start_point: Point,
    target_point: Point,
    do_something: Iterable[CommandCode],
) -> Iterable[CommandCode]:
    for code in chain(
        move_to(start_point, target_point),
        do_something,
        move_to(target_point, start_point),
    ):
        yield code

def move_to_do_sth_and_move_to(
    start_point: Point,
    target_point: Point,
    do_something: Iterable[CommandCode],
    next_point: Point,
) -> Iterable[CommandCode]:
    for code in chain(
        move_to(start_point, target_point),
        do_something,
        move_to(target_point, next_point),
    ):
        yield code


def drop(items: int) -> Iterable[OneArgCode]:
    _require_positive(items)
    yield (CodeIndex.DROP, (items,))

def get(items: int) -> Iterable[OneArgCode]:
    _require_positive(items)
    yield (CodeIndex.GET, (items,))

def goto(rel_lineno: int) -> Iterable[OneArgCode]:
    if rel_lineno == 0:
        raise ValueError("`rel_lineno` requires a non-zero interger.")
    yield (CodeIndex.GOTO, (rel_lineno,))

def drop_plate() -> Iterable[NoArgCode]:
    yield (CodeIndex.DROP_PLATE, ())

def get_plate() -> Iterable[NoArgCode]:
    yield (CodeIndex.GET_PLATE, ())

def stand_still() -> Iterable[NoArgCode]:
    yield (CodeIndex.STAND_STILL, ())

def if_ge_and_goto(items: int, rel_lineno: int) -> Iterable[TwoArgsCode]:
    if items <= 0:
        raise ValueError(
            f"`items` requires a positive integer, but got {items}.")
    yield (CodeIndex.IF_GE_AND_GOTO, (items, rel_lineno))


class Condition:
    less_than: int
    then: Iterable[CommandCode]

    def __init__(self, *, lt: int, then: Iterable[CommandCode]):
        self.less_than = lt
        self.then = then


class IfCondition(Condition):
    pass

class ElifCondition(Condition):
    pass


def if_lt_elif_lt_else(
    if_: IfCondition,
    *elif_args: ElifCondition,
    else_: Iterable[CommandCode] = (),
) -> List[CommandCode]:
    """see `test_utils.TestUtils.test_if_lt_elif_lt_else`"""

    if_codes: List[CommandCode] = list(if_.then)

    elifs_codes: List[List[CommandCode]]
    elifs_codes = [list(elif_.then) for elif_ in elif_args]

    else_codes: List[CommandCode] = list(else_)

    # start `if` block
    res_codes: List[CommandCode] = []
    res_codes.extend(if_ge_and_goto(if_.less_than, len(if_codes) + 2))
    res_codes.extend(if_codes)

    # each block needs an `IF_GE_AND_GOTO` command and a `GOTO` command
    GOTO_COMMANDS: Final = 2
    total_codes: int = (
        sum(map(len, elifs_codes))
        + len(elifs_codes) * GOTO_COMMANDS
        + len(else_codes)
        + 1
    )
    res_codes.extend(goto(total_codes))
    # `if` block done

    # `elif` blocks
    for elif_, codes in zip(elif_args, elifs_codes):
        res_codes.extend(
            if_ge_and_goto(elif_.less_than, len(codes) + GOTO_COMMANDS)
        )
        res_codes.extend(codes)
        total_codes -= len(codes) + GOTO_COMMANDS
        res_codes.extend(goto(total_codes))

    # `else` block
    res_codes.extend(else_codes)

    return res_codes


def while_lt(
    while_less_than: int,
    loop: Iterable[CommandCode],
) -> List[CommandCode]:
    codes: List[CommandCode] = list(loop)
    res_codes: List[CommandCode] = []

    res_codes.extend(if_ge_and_goto(while_less_than, len(codes) + 2))
    res_codes.extend(codes)
    res_codes.extend(goto(-len(codes) - 1))

    return res_codes


def do_while_ge(*,
    do: Iterable[CommandCode],
    while_ge: int,
) -> List[CommandCode]:
    codes: List[CommandCode] = list(do)
    length = len(codes)

    res_codes = codes
    res_codes.extend(if_ge_and_goto(while_ge, -length))

    return res_codes


def loop_forever(loop: Iterable[CommandCode]) -> List[CommandCode]:
    codes: List[CommandCode] = list(loop)
    length = len(codes)

    res_codes = codes
    res_codes.extend(goto(-length))

    return res_codes


@dataclass
class MoveHelper:
    pos: Point = (0, 0)

    def move_to_do_sth_and_return(
        self, target_point: Point, do_something: Iterable[CommandCode]
    ) -> Iterable[CommandCode]:
        return move_to_do_sth_and_return(self.pos, target_point, do_something)

    def move_to_do_sth_and_move_to(
        self,
        target_point: Point,
        do_something: Iterable[CommandCode],
        next_point: Point,
    ) -> Iterable[CommandCode]:
        codes = move_to_do_sth_and_move_to(
            self.pos, target_point, do_something, next_point)
        self.pos = next_point
        return codes

