"""a simple TerminatedFrameReceiver by @njsmith.
https://github.com/python-trio/trio/issues/796#issuecomment-471428274
"""

import trio

_RECEIVE_SIZE = 4096  # pretty arbitrary

class TerminatedFrameReceiver:
    """Parse frames out of a Trio stream, where each frame is terminated by a
    fixed byte sequence.

    For example, you can parse newline-terminated lines by setting the
    terminator to b"\\n".

    This uses some tricks to protect against denial of service attacks:

    - It puts a limit on the maximum frame size, to avoid memory overflow; you
    might want to adjust the limit for your situation.

    - It uses some algorithmic trickiness to avoid "slow loris" attacks. All
      algorithms are amortized O(n) in the length of the input.

    """
    def __init__(self, stream, terminator, max_frame_length=16384):
        self.stream = stream
        self.terminator = terminator
        self.max_frame_length = max_frame_length
        self._buf = bytearray()
        self._next_find_idx = 0

    async def receive(self):
        while True:
            terminator_idx = self._buf.find(
                self.terminator, self._next_find_idx
            )
            if terminator_idx < 0:
                # no terminator found
                if len(self._buf) > self.max_frame_length:
                    raise ValueError("frame too long")
                # next time, start the search where this one left off
                self._next_find_idx = max(0, len(self._buf) - len(self.terminator) + 1)
                # add some more data, then loop around
                more_data = await self.stream.receive_some(_RECEIVE_SIZE)
                if more_data == b"":
                    if self._buf:
                        raise ValueError("incomplete frame")
                    raise trio.EndOfChannel
                self._buf += more_data
            else:
                # terminator found in buf, so extract the frame
                frame = self._buf[:terminator_idx]
                # Update the buffer in place, to take advantage of bytearray's
                # optimized delete-from-beginning feature.
                del self._buf[:terminator_idx+len(self.terminator)]
                # next time, start the search from the beginning
                self._next_find_idx = 0
                return frame

    def __aiter__(self):
        return self

    async def __anext__(self):
        try:
            return await self.receive()
        except trio.EndOfChannel:
            raise StopAsyncIteration


def example():
    from trio.testing import memory_stream_pair
    async def main():
        sender_stream, receiver_stream = memory_stream_pair()

        async def sender():
            await sender_stream.send_all(b"hello\r\n\r\n")
            await trio.sleep(1)
            await sender_stream.send_all(b"split-up ")
            await trio.sleep(1)
            await sender_stream.send_all(b"message\r\n\r")
            await trio.sleep(1)
            await sender_stream.send_all(b"\n")
            await trio.sleep(1)
            await sender_stream.send_all(b"goodbye\r\n\r\n")
            await trio.sleep(1)
            await sender_stream.aclose()

        async def receiver():
            chan = TerminatedFrameReceiver(receiver_stream, b"\r\n\r\n")
            async for message in chan:
                print(f"Got message: {message!r}")

        async with trio.open_nursery() as nursery:
            nursery.start_soon(sender)
            nursery.start_soon(receiver)

    trio.run(main)

