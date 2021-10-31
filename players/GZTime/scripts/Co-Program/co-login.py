from z3 import *
from lark import Lark, Transformer, v_args, Tree
from pwn import *
from tqdm import tqdm

# context.log_level = 'debug'

token = b'your token here'

BOUNDRY = 2 ** 36 - 1

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

def init_conn(token):
    io = remote('202.38.93.111', 10700)
    io.sendlineafter(b'token: ', token)
    io.recvline()
    return io

def get_problem():
    expr = io.recvline().decode().strip()
    ans = int(io.recvline().decode().strip())
    return expr, ans

def answer_problem(vars_):
    io.sendline(' '.join(f'{i[0]}={i[1] if i[1] is not None else 0}' for i in vars_).encode())

@v_args(inline=True)
class Convertor(Transformer):
    from operator import add, sub, mul, neg

    def div(self, a, b):
        return If(b == 0, BOUNDRY, UDiv(a, b))

    def mod(self, a, b):
        return If(b == 0, a, URem(a, b))

    def __init__(self):
        self.vars = {}

    def var(self, name):
        if name[0] not in self.vars.keys():
            self.vars[name[0]] = BitVec(name, 36)
        return self.vars[name[0]]

def init_parser(convertor):
    return Lark(GRAM, parser='lalr', transformer=convertor)

def solve_with_return(*args, **keywords):
    so = Solver()
    so.set(**keywords)
    so.add(*args)
    r = so.check()
    if r == unsat:
        return None
    elif r == unknown:
        try:
            return so.model()
        except Z3Exception:
            return None
    else:
        return so.model()

if __name__ == '__main__':
    convertor = Convertor()
    parse = init_parser(convertor).parse
    io = init_conn(token)

    for _ in tqdm(range(100)):
        expr, ans = get_problem()
        try:
            question = parse(expr)
            result = solve_with_return(question == ans)

            if result is None:
                raise TypeError

            to_send = []
            for name in convertor.vars.keys():
                to_send.append([name, result[convertor.vars[name]]])

            answer_problem(to_send)
        except:
            io.sendline()
        finally:
            convertor.vars.clear()

    print(io.recvall())
