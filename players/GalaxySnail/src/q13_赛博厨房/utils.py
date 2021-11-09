from typing import NoReturn


class UnreachableError(BaseException):
    pass


def require_positive(n: int):
    if n <= 0:
        raise ValueError(f"Requires a positive integer, but got {n}.")

def assert_never(value: NoReturn) -> NoReturn:
    raise AssertionError(
        f"This code should be unreachable, but got {value!r}")

