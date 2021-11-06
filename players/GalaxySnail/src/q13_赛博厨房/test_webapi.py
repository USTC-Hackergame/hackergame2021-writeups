import unittest

from webapi import *

class TestHandleResponseJson(unittest.TestCase):

    def test_parse_seed(self) -> None:
        res = {
            'status': 'error',
            'message': ('Seed is not correct, should be '
                        '51157411270304d3505398e32d012aba5444ebf664c137081053b3273920f77a.')
        }
        self.assertEqual(
            handle_response_json(res)["seed"],  # type: ignore  # pylint: disable=unsubscriptable-object
            "51157411270304d3505398e32d012aba5444ebf664c137081053b3273920f77a"
        )

    def test_parse_recipe(self) -> None:
        res = {
            'status': 'error',
            'message': 'No win. The recipe should be [5,22,24,6,26,5].'
        }
        self.assertEqual(
            handle_response_json(res)["recipe"],  # type: ignore  # pylint: disable=unsubscriptable-object
            [5, 22, 24, 6, 26, 5]
        )

