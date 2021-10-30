# Co-Program

## Co-UnitTest

给了 `if` 和 `=`，直接二进制凑常数就行。

```python
from time import sleep
from sys import stderr


def f(n: int) -> str:
    if n == 0:
        return '(x-x)'
    if n == 1:
        return '(x/x)'
    if n == 2:
        return '(x/x+x/x)'
    if n % 2 == 0:
        return f'({f(n // 2)}*{f(2)})'
    return f'({f(n // 2)}*{f(2)}+{f(1)})'


def solve(a) -> str:
    if len(a) == 1:
        return f(a[0][2])
    return f'if(x={f(a[0][0])},{f(a[0][2])},{solve(a[1:])})'


def work():
    sleep(10)
    s = []
    for _ in range(5):
        st = input()
        while st.find("x=") == -1:
            print(st, file=stderr)
            st = input()
        t = list(map(int, st.replace('x=', '').replace(', y=', ' ').replace(', ans=', ' ').split()))
        s.append(t)
    print(solve(s))


print('<token>')
while True:
    work()
```

## Co-Login

第二问的 flag 告诉我们有个东西叫 cvc5，发现好像可以用来做这问。

本来想说出题人是不是放错 flag 了，然后发现直接用 cvc5 不太行，只有 50%～60% 能做出来，不知道是不是我写假了。

然后找到了 [Satisfiability modulo theories - Wikipedia](https://en.wikipedia.org/wiki/Satisfiability_modulo_theories#SMT_solvers)，试了好几个，发现 z3 还可以，写了个脚本，人工多线程跑了不到半个小时就出来了。

```python
from os import system
from random import randint
from re import sub
from sys import stderr


class Expr:
    s = ''

    def __init__(self, s) -> None:
        if s is int and s < 0:
            self = -Expr(-s)
        else:
            self.s = str(s)

    def __add__(self, other):
        return Expr(f'(add {self.s} {other.s})')

    def __sub__(self, other):
        return Expr(f'(minus {self.s} {other.s})')

    def __mul__(self, other):
        return Expr(f'(mul {self.s} {other.s})')

    def __truediv__(self, other):
        return Expr(f'(divv {self.s} {other.s})')

    def __mod__(self, other):
        return Expr(f'(modd {self.s} {other.s})')

    def __neg__(self):
        return Expr(f'(minus 0 {self.s})')

    def __str__(self):
        return self.s


def toExpr(s):
    return f'Expr({s.group()})'


i = Expr('i')
j = Expr('j')
k = Expr('k')
x = Expr('x')
y = Expr('y')
z = Expr('z')

print('<token>')
print(input(), file=stderr)

pattern = '''(set-logic ALL)
(set-option :produce-models true)

(
    define-fun m ((x Int)) Int
    (mod x 68719476736)
)

(
    define-fun add ((a Int) (b Int)) Int
    (m (+ a b))
)

(
    define-fun minus ((a Int) (b Int)) Int
    (m (- (+ a 68719476736) b))
)

(
    define-fun mul ((a Int) (b Int)) Int
    (m (* a b))
)

(
    define-fun divv ((a Int) (b Int)) Int
    (ite (= b 0) 68719476735 (div a b))
)

(
    define-fun modd ((a Int) (b Int)) Int
    (ite (= b 0) a (mod a b))
)

(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)
(declare-fun i () Int)
(declare-fun j () Int)
(declare-fun k () Int)
(assert (>= x 0))
(assert (< x 68719476736))
(assert (>= y 0))
(assert (< y 68719476736))
(assert (>= z 0))
(assert (< z 68719476736))
(assert (>= i 0))
(assert (< i 68719476736))
(assert (>= j 0))
(assert (< j 68719476736))
(assert (>= k 0))
(assert (< k 68719476736))

(assert (= expr answer))
(check-sat)
(get-value (i))
(get-value (j))
(get-value (k))
(get-value (x))
(get-value (y))
(get-value (z))
'''

id = randint(10**8, 10**9 - 1)
print('id:', id, file=stderr)

for index in range(100):
    print(index, file=stderr)
    rawinput = input()
    s = eval(sub('\d+', toExpr, rawinput))
    ans = int(input())
    with open(f'cvc-in.{id}.txt', 'w') as f:
        f.write(pattern.replace('expr', str(s)).replace('answer', str(ans)))
    # if system(f'timeout 3s mathsat cvc-in.{id}.txt > cvc-out.{id}.txt') != 0:
    # if system('./cvc5-Linux --lang smt2 --tlimit 3000 cvc-in.txt > cvc-out.txt') != 0:
    if system(f'z3 -T:3 cvc-in.{id}.txt > cvc-out.{id}.txt') != 0:
        print('timeout', file=stderr)
        print()
        continue
    with open(f'cvc-out.{id}.txt') as f:
        results = f.read().split('\n')
        if results[0] == 'sat':
            lis = []
            assert (len(results) == 8)
            dic = ['i', 'j', 'k', 'x', 'y', 'z']
            for c in dic:
                if rawinput.find(c) != -1:
                    lis.append(f'{c}={results[dic.index(c)+1].replace(f"(({c} ","").replace("))","")}')
            print(' '.join(lis))
        else:
            print(results[0], file=stderr)
            print()
print(input(), file=stderr)
```

（赛后才知道有 Python 库可以用，不用 `system`……）
