import asyncio
import collections
import itertools
import typing


token = '<Redacted>'
server_host = '202.38.93.111'
server_port = 10800


def get_number(x: int, y: int, ans: int) -> str:
    if ans == 0:
        return '(x-x)'

    if x != 0:
        one = '(x/x)'
    elif y != 0:
        one = '(y/y)'
    else:
        one = '((x/x)/(x/x))'

    two = f'({one}+{one})'

    d = collections.deque((one,))

    for bit in itertools.islice(bin(ans), 3, None):
        d.appendleft('(')
        d.extend(('*', two, ')'))
        if bit == '1':
            d.appendleft('(')
            d.extend(('+', one, ')'))

    return ''.join(d)

# TODO: Handle negative number?

def stack_one_case(x: int, y: int, ans: int) -> typing.List[str]:
    return [
        'if(((x=',
        get_number(x, y, x),
        ')&&(y=',
        get_number(x, y, y),
        ')),',
        get_number(x, y, ans),
        ',',
    ]

def solve(cases: typing.Sequence[typing.Sequence[int]]) -> str:
    result = collections.deque()
    for i, case in enumerate(cases):
        if i == 0:
            result.append(get_number(*case))
        else:
            result.extendleft(reversed(stack_one_case(*case)))
            result.append(')')
    return ''.join(result)


async def main() -> None:
    # x = 37
    # y = 43
    # ans = 12345678
    # s = get_number(x, y, ans)
    # print(s)
    # print(len(s))
    # print(eval(s))
    # assert(eval(s) == ans)

    # cases = []
    # x=21419314478
    # y=47599200002
    # ans=20522201246
    # cases.append((x, y, ans))
    # x=23916443849
    # y=25102677129
    # ans=14298034387
    # cases.append((x, y, ans))
    # x=50324426130
    # y=48448305333
    # ans=28884138685
    # cases.append((x, y, ans))
    # x=11636800575
    # y=55024141665
    # ans=17812404063
    # cases.append((x, y, ans))
    # x=19216665766
    # y=26441173260
    # ans=19682102160
    # cases.append((x, y, ans))

    # print(len(solve(cases)))

    # cases = [[1, 1, 1]]
    # print(solve(cases))
    # exit()

    reader, writer = await asyncio.open_connection(server_host, server_port)
    writer.write((token + '\n').encode())
    print(await reader.readline())
    
    # await writer.drain()
    for _ in range(10):
        while True:
            line = await reader.readline()
            print(line)
            if line == b'Challenge!\n':
                break

        cases = [[int(s.partition('=')[2].rstrip(',')) for s in (await reader.readline()).decode().split()] for _ in range(5)]
        print(cases)

        answer = solve(cases)
        # print(answer)
        print(len(answer))
        writer.write(answer.encode())
        writer.write(b'\n')
        await writer.drain()

    print((await reader.read()).decode())
    writer.close()
    await writer.wait_closed()

if __name__ == '__main__':
    asyncio.run(main())
