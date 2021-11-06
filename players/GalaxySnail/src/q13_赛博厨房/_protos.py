# pylint: disable=used-before-assignment
import typing
from typing import Literal, TypeVar, Protocol

if typing.TYPE_CHECKING:
    from _typeshed import SupportsWrite, ReadableBuffer


T = TypeVar("T")
T_co = TypeVar("T_co", covariant=True)
T_contra = TypeVar("T_contra", contravariant=True)

# because of `AnyStr`, `typing.IO` can't save us
class File(SupportsWrite[T_contra], Protocol):
    def close(self) -> None: ...
    def flush(self) -> None: ...


raise RuntimeError("Never import it at runtime. Use typing.TYPE_CHECKING.")

