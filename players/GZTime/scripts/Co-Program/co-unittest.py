from z3 import *
from lark import Lark, Transformer, v_args, Tree
from pwn import *
from tqdm import tqdm
import random

context.log_level = 'debug'

token = b'your token here'

GRAM = '''?start: sum

?sum: product
    | sum "+" product   -> add
    | sum "-" product   -> sub

?product: atom
    | product "*" atom  -> mul
    | product "/" atom  -> div
    | product "%" atom  -> mod

?atom: NAME             -> var
    | "-" atom          -> neg
    | "(" sum ")"

%import common.CNAME -> NAME
%import common.NUMBER
%import common.WS_INLINE
%ignore WS_INLINE'''

operations = ['-', '+', '*', '/', '%']

BOUNDRY = 2 ** 36

MAX_DEPTH = 4

@v_args(inline=True)
class Convertor(Transformer):
    def neg(self, a):
        return (-a) % BOUNDRY

    def mul(self, a, b):
        return (a * b) % BOUNDRY

    def sub(self, a, b):
        return (a - b) % BOUNDRY

    def add(self, a, b):
        return (a + b) % BOUNDRY

    def div(self, a, b):
        return BOUNDRY - 1 if b == 0 else a // b

    def mod(self, a, b):
        return a if b == 0 else a % b

    def __init__(self):
        self.vars = {}

    def assign(self, x, y):
        self.vars['x'] = x
        self.vars['y'] = y

    def var(self, name):
        if name[0] not in self.vars.keys():
            return 0
        return self.vars[name[0]]

def init_parser(convertor):
    return Lark(GRAM, parser='lalr', transformer=convertor)

def init_conn(token):
    io = remote('202.38.93.111', 10800)
    io.sendlineafter(b'token: ', token)
    return io

def get_problem():
    io.recvuntil(b'Challenge!\n')
    problem = []
    for _ in range(5):
        line = io.recvline().decode().strip()
        problem.append([int(item.split('=')[1]) for item in line.split(', ')])
    return problem

def solve_easy(problems):
    easy = True
    for item in problems:
        if item[2] != 0:
            easy = False
            break
    if easy:
        io.sendline(b'x-x')
        return True
    easy = True
    for item in problems:
        if item[2] != BOUNDRY - 1:
            easy = False
            break
    if easy:
        io.sendline(b'x/(x-x)')
        return True
    return False

def gen_expr(depth = 0):
    if depth == 2:
        for item in ['x', 'y']:
            yield item

    if depth == 2:
        return

    for op in operations:
        for lval in gen_expr(depth + 1):
            for rval in gen_expr(depth + 1):
                if lval == rval and op == '-':
                    continue
                yield f'({lval}{op}{rval})'


io = init_conn(token)
convertor = Convertor()
assign = convertor.assign
calc = init_parser(convertor).parse

for _ in range(10):
    problems = get_problem()
    if solve_easy(problems):
        continue

    equals = {}
    for idx, problem in enumerate(problems):
        assign(problem[0], problem[1])
        for expr in gen_expr():
            res = calc(expr)
            if res == problem[2]:
                equals[idx] = expr
                break
            elif (-res) % BOUNDRY == problem[2]:
                equals[idx] = f'(-{expr})'
                break

    if len(equals.keys()) < 5:
        io.sendline()
        continue

    use = {}

    for i in range(5):
        x = problems[i][0]
        for expr in gen_expr():
            assign(problems[i][0], problems[i][1])
            if x > calc(expr):
                continue

            fail = False
            for j in range(5):
                if i == j:
                    continue
                assign(problems[j][0], problems[j][1])
                if problems[j][0] <= calc(expr):
                    fail = True
                    break
            if fail:
                continue

            use[i] = expr
            break

    if len(use.keys()) < 4:
        io.sendline()
        continue

    no_use = set(range(5)) - set(use.keys())
    if len(no_use) > 0:
        no_use = list(no_use)[0]
    else:
        no_use = 4
        use.pop(4)

    result = equals[no_use]
    for item in use.keys():
        result = f'if(x<={use[item]},{equals[item]},{result})'

    io.sendline(result)

io.recvall()

