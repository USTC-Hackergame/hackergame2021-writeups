#!/usr/bin/env python3

game_board = [[[' ' for i in range(0x100)] for j in range(0x100)] for k in range(0x100)]
stack = []
pc = [0, 0, 0]
direction = [1, 0, 0]
str_mode = 0
output = ""
input_ = ""

result = 0xdeadbeef
success_cnt = 0

DEBUG = 1


def debug(s):
    if DEBUG:
        print(s)


def init_game():
    global stack, pc, direction, str_mode, output, input_, result
    stack = []
    pc = [0, 0, 0]
    direction = [1, 0, 0]
    str_mode = 0
    output = ""
    input_ = ""
    result = 0xdeadbeef
    gen_calc_formula()


def check_result():
    if int(output) == result:
        return 1
    return -1


expression = ''


def gen_calc_formula():

    global input_, result, expression

    operations = ['+', "*", "^", "x", "|", "<"]
    length = random.randint(5, 9)
    result = random.randint(1, 9)

    input_ += str(result)

    for _ in range(length):
        operation = operations[random.randint(0, len(operations) - 1)]
        operand = random.randint(1, 9)

        if operation == '+':
            result += operand
        elif operation == '*':
            result *= operand
        elif operation == '^':
            result = int(result**operand)
        elif operation == 'x':
            result ^= operand
        elif operation == '|':
            result |= operand
        elif operation == '<':
            result <<= operand
        else:
            debug("[x] Unexpected Error")
            exit()

        input_ += operation
        input_ += str(operand)

    # result = 12
    # input_ = '3<2'

    input_ += '\x00'

    expression = input_
    debug('input: ' + input_)


def op(x):
    global str_mode, direction, output, input_, stack
    if str_mode and x != '\"':
        stack.append(ord(x))
        return
    if x == '+':
        debug('[-] +')
        stack.append(stack.pop() + stack.pop())
    elif x == '-':
        debug('[-] -')
        stack.append(-stack.pop() + stack.pop())
    elif x == '*':
        debug('[-] *')
        stack.append(stack.pop() * stack.pop())
    elif x == '/':
        debug('[-] /')
        v2 = stack.pop()
        v1 = stack.pop()
        stack.append(v1 // v2)
    elif x == '%':
        debug('[-] %')
        v2 = stack.pop()
        v1 = stack.pop()
        stack.append(v1 % v2)
    elif x == '!':
        debug('[-] !')
        if stack.pop():
            stack.append(0)
        else:
            stack.append(1)
    elif x == '`':
        debug('[-] `')
        v2 = stack.pop()
        v1 = stack.pop()
        if v1 > v2:
            stack.append(1)
        else:
            stack.append(0)
    elif x == '>':
        debug('[-] >')
        direction = [1, 0, 0]
    elif x == '<':
        debug('[-] <')
        direction = [-1, 0, 0]
    elif x == '^':
        debug('[-] ^')
        direction = [0, -1, 0]
    elif x == 'v':
        debug('[-] v')
        direction = [0, 1, 0]
    elif x == '[':
        debug('[-] [')
        direction = [0, 0, 1]
    elif x == ']':
        debug('[-] ]')
        direction = [0, 0, -1]
    elif x == '?':
        pass
    elif x == '_':
        debug('[-] _')
        if stack.pop():
            direction = [-1, 0, 0]
        else:
            direction = [1, 0, 0]
    elif x == '|':
        debug('[-] |')
        if stack.pop():
            direction = [0, -1, 0]
        else:
            direction = [0, 1, 0]
    elif x == '#':
        debug('[-] #')
        if stack.pop():
            direction = [0, 0, -1]
        else:
            direction = [0, 0, 1]
    elif x == '\"':
        debug('[-] \"')
        if str_mode:
            str_mode = 0
        else:
            str_mode = 1
    elif x == ':':
        debug('[-] :')
        v1 = stack.pop()
        stack.append(v1)
        stack.append(v1)
    elif x == '\\':
        debug('[-] \\')
        v1 = stack.pop()
        v2 = stack.pop()
        temp = stack[-v1]
        stack[-v1] = stack[-v2]
        stack[-v2] = temp
    elif x == '$':
        debug('[-] $')
        stack.pop()
    elif x == '.':
        debug('[-] .')
        output += "{:d}".format(stack.pop())
    elif x == ',':
        debug('[-] ,')
        output += "{:c}".format(stack.pop() & 0xff)
    elif x == '&':
        pass
    elif x == '~':
        debug('[-] ~')
        # if input_[0] == '\x00':
        # return check_result()
        stack.append(ord(input_[0]))
        input_ = input_[1:]
    elif x == '@':
        debug('[-] @')
        print("Bye Bye~")
        return check_result()
    elif x >= '0' and x <= '9':
        debug('[-] {}'.format(ord(x) - ord('0')))
        stack.append(ord(x) - ord('0'))
    elif x == ' ':
        pass
    else:
        debug("[x] Unknown Operation")

    return 0


def game():
    global game_board, pc, success_cnt
    while (0 <= pc[0] < 0x100 and 0 <= pc[1] < 0x100 and 0 <= pc[2] < 0x100):
        if pc[:2] in [[10, 7], [82, 1]]:
            tempora = 1
        result = op(game_board[pc[0]][pc[1]][pc[2]])
        if result == 1:
            success_cnt += 1
            return
        elif result == -1:
            debug("[x] Wrong Answer")
            exit(-1)
        for i in range(3):
            pc[i] += direction[i]
        debug(pc)
    debug("[x] Out of Bound")
    exit()


if __name__ == '__main__':
    import re
    import random
    with open("/dev/urandom", 'rb') as f:
        seed_b = f.read(7)
    seed = int.from_bytes(seed_b, byteorder="little")
    random.seed(seed)

    ### Your input should be like
    ###     (1, 2, 3) -> 4 (5, 6, 7) -> 8 (233, 234, 235)-> 66 END
    re_c = re.compile(r"^(?:\(\s*(?P<x>\d+)\s*,\s*(?P<y>\d+)\s*,\s*(?P<z>\d+)\s*\)\s*?->\s*?(?P<v>\d+)\s*?)+\s+?END$",
                      re.DOTALL)
    single_c = re.compile(r"\(\s*(?P<x>\d+)\s*,\s*(?P<y>\d+)\s*,\s*(?P<z>\d+)\s*\)\s*?->\s*?(?P<v>\d+)\s*")
    s = input('>')
    if re_c.match(s):
        map = single_c.findall(s)
        for x, y, z, v in map:
            x, y, z, v = int(x), int(y), int(z), int(v)
            assert (0 <= x < 0x100 and 0 <= y < 0x100 and 0 <= z < 0x100 and 0 <= v < 0x100)
            game_board[x][y][z] = chr(v)
    else:
        print("Wrong Input")
        exit(-1)

    for i in range(0x20):
        init_game()
        try:
            game()
        except Exception as e:
            debug(e)
            exit()

    if success_cnt == 0x20:
        with open("flag", "r") as f:
            print(f.read())
