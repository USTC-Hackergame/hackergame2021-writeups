"""tests, also examples"""
import unittest
from itertools import chain

from compiler import *

class TestCompiler(unittest.TestCase):

    def test_if_lt_elif_lt_else1(self) -> None:
        res = if_lt_elif_lt_else(
            IfCondition(lt=4,
                then=move_to((0, 0), (11, 2)),
            ),
            ElifCondition(lt=8,
                then=move_to((0, 0), (-12, -4)),
            ),
            ElifCondition(lt=16,
                then=move_to((0, 0), (13, 8)),
            ),
            else_=move_to((0, 0), (42, 42)),
        )
        self.assertEqual(
            res,
            # if val < 4
            [(CodeIndex.IF_GE_AND_GOTO, (4, 4)),
             (CodeIndex.RIGHT, (11,)),
             (CodeIndex.DOWN, (2,)),
             (CodeIndex.GOTO, (11,)),
            # elif val < 8
             (CodeIndex.IF_GE_AND_GOTO, (8, 4)),
             (CodeIndex.LEFT, (12,)),
             (CodeIndex.UP, (4,)),
             (CodeIndex.GOTO, (7,)),
            # elif val < 16
             (CodeIndex.IF_GE_AND_GOTO, (16, 4)),
             (CodeIndex.RIGHT, (13,)),
             (CodeIndex.DOWN, (8,)),
             (CodeIndex.GOTO, (3,)),
            # else
             (CodeIndex.RIGHT, (42,)),
             (CodeIndex.DOWN, (42,))]
        )

    def test_if_lt_elif_lt_else2(self) -> None:
        res = if_lt_elif_lt_else(
            IfCondition(lt=4,
                then=move_to((0, 0), (0, 11)),
            ),
            ElifCondition(lt=8,
                then=move_to((0, 0), (-12, 0)),
            ),
            ElifCondition(lt=16,
                then=move_to((0, 0), (13, 8)),
            ),
            else_=move_to((0, 0), (42, 42)),
        )
        self.assertEqual(
            res,
            [(CodeIndex.IF_GE_AND_GOTO, (4, 3)),
             (CodeIndex.DOWN, (11,)),
             (CodeIndex.GOTO, (10,)),
             (CodeIndex.IF_GE_AND_GOTO, (8, 3)),
             (CodeIndex.LEFT, (12,)),
             (CodeIndex.GOTO, (7,)),
             (CodeIndex.IF_GE_AND_GOTO, (16, 4)),
             (CodeIndex.RIGHT, (13,)),
             (CodeIndex.DOWN, (8,)),
             (CodeIndex.GOTO, (3,)),
             (CodeIndex.RIGHT, (42,)),
             (CodeIndex.DOWN, (42,))]
        )

    def test_while_lt(self) -> None:
        res = while_lt(73, chain(
            move_to((0, 0), (2, 1)),
            get(1),
        ))
        self.assertEqual(
            res,
            [(CodeIndex.IF_GE_AND_GOTO, (73, 5)),
             (CodeIndex.RIGHT, (2,)),
             (CodeIndex.DOWN, (1,)),
             (CodeIndex.GET, (1,)),
             (CodeIndex.GOTO, (-4,))]
        )

    def test_do_while_ge(self) -> None:
        res = do_while_ge(do=chain(
            move_to((0, 0), (2, 1)),
            drop(1),
        ), while_ge=1)
        self.assertEqual(
            res,
            [(CodeIndex.RIGHT, (2,)),
             (CodeIndex.DOWN, (1,)),
             (CodeIndex.DROP, (1,)),
             (CodeIndex.IF_GE_AND_GOTO, (1, -3))]
        )

    def test_loop_forever(self) -> None:
        res = loop_forever(loop=chain(
            move_to((0, 0), (1, 4)),
            drop(1),
        ))
        self.assertEqual(
            res,
            [(CodeIndex.RIGHT, (1,)),
             (CodeIndex.DOWN, (4,)),
             (CodeIndex.DROP, (1,)),
             (CodeIndex.GOTO, (-3,))]
        )

    def test_if_and_loops1(self) -> None:
        res = if_lt_elif_lt_else(
            IfCondition(lt=8, then=chain(
                move_to((0, 0), (2, 2)),
                get(2),
            )),
            else_=chain(
                move_to((0, 0), (1, 1)),
                do_while_ge(do=chain(
                    move_to((0, 0), (1, 0)),
                    drop(1),
                ), while_ge=1)
            )
        )
        self.assertEqual(
            res,
            # if val < 8
            [(CodeIndex.IF_GE_AND_GOTO, (8, 5)),
             (CodeIndex.RIGHT, (2,)),
             (CodeIndex.DOWN, (2,)),
             (CodeIndex.GET, (2,)),
             (CodeIndex.GOTO, (6,)),
            # else
             (CodeIndex.RIGHT, (1,)),
             (CodeIndex.DOWN, (1,)),
             (CodeIndex.RIGHT, (1,)),
             (CodeIndex.DROP, (1,)),
             (CodeIndex.IF_GE_AND_GOTO, (1, -2))]
        )

