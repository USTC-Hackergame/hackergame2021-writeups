import asyncio
import socket
import time

token = '<Redacted>'
server_host = '202.38.93.111'
server_port = 10700


async def main() -> None:
    reader, writer = await asyncio.open_connection(server_host, server_port)
    writer.write((token + '\n').encode())
    print(await reader.readline())
    # await writer.drain()
    for _ in range(100):
        expression = (await reader.readline()).decode().rstrip('\n')
        print(expression)
        result = int(await reader.readline())
        print(result)
        # break
        writer.write(b'\n')
        # await writer.drain()
    print((await reader.read()).decode())
    writer.close()
    await writer.wait_closed()


if __name__ == '__main__':
    asyncio.run(main())
