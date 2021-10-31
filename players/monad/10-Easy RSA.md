# Easy RSA

**公式不渲染警告**，建议移步至[我的博客](https://blog.monadx.com/2021/10/31/Hackergame-2021/#easy-rsa)。

观察代码，我们有三个任务：

1. 计算 `p`
2. 通过 `value[-1]` 反推全部 `value`
3. 通过 `value_q` 反推 `q`

## 1. 计算 `p`

查找资料，可以找到一个叫“威尔逊定理”的东西，即当 `p` 为质数的时候，有：

$$
(p - 2)! \equiv 1 \enspace (\operatorname{mod} p)
$$

则：

$$
y! \equiv (x - 2)! \times \frac{y!}{(x - 2)!} \equiv \frac{1}{\prod_{i = y + 1}^{x - 2} i} \equiv \prod_{i = y + 1}^{x - 2} inv(i) \quad (\operatorname{mod} x)
$$

代码：

```python
def get_p(x, y):
    mul = 1
    for i in range(y + 1, x - 2 + 1):
        mul = mul * pow(i, x, x - 2) % x
    return mul
```

## 2. 反推 `value`

这个部分涉及到一个最主要的函数就是 `sympy.nextprime`，先看看它的文档：

> `def nextprime(n, ith = 1)`  
> Return the ith prime greater than n.  
> See Also: prevprime: Return the largest prime smaller than n.

……我感觉官方文档都告诉你应该怎么做了。

```python
def get_first_value(last_value):
    val = last_value
    for _ in range(9):
        val = sympy.prevprime(val)
    return val
```

## 3. 反推原始 `q`

这个部分就是给出这个式子（我们把这个原始的 `q` 称为 `x`）：

$$
q \equiv x^e \enspace (\operatorname{mod} n)
$$

已知 `e`, `n`, `q`，求 `x`。

然而我不会求，查资料，发现了这个：[Finding the k-th root modulo m](https://math.stackexchange.com/questions/2073284/finding-the-kth-root-modulo-m)，简直完美。

按照这篇文章（回答）所说，首先求满足这一式子的 $u$, $v$：

$$
u \, e - v \, \varphi(n) = 1
$$

显然 $\gcd(e, \, \varphi(n)) = 1$，这一步可以用 exgcd 做。

求出来了之后，就有

$$
x \equiv (b^u)^e \enspace (\operatorname{mod} n)
$$

写成代码，就是：

```python
# 这里的 n 我们通过 `first_value` 生成
def get_original_q(e, q, first_value):
    value = [ first_value ]
    n = first_value
    for i in range(1, 10):
        value.append(sympy.nextprime(value[i - 1]))
        n *= value[-1]

    # 这样求 phi 可以快不少，该函数要求 factors 中的 keys 都是质数。
    factors = { v: 1 for v in value }
    pn = sympy.ntheory.factor_.totient._from_factors(factors)

    # Ex-GCD, 其中 h = gcd(e, pn)；u, v 含义如上所述。
    (u, v, h) = sympy.polys.polytools.gcdex(e, pn)

    x = pow(q, int(u) * e, n)
    return x
```

经过验证，以上三个脚本都可以算出的结果，代入进源程序中，都可以算出源码中对应的结果。

## 4. RSA 解密

RSA 解密还需要一个数 $d$（含义请自行翻看 RSA 文档，也可以看[这篇](https://www.ruanyifeng.com/blog/2013/07/rsa_algorithm_part_two.html)）。

算 $d$ 满足以下式子：

$$
ed \equiv 1 \enspace (\operatorname{mod} n)
$$

在先进的 `Python 3.8+` 中，可以直接用 `pow(x, -1, mod)` 来算逆元，省事不少。

于是解密部分的代码：

```python
pn = sympy.ntheory.factor_.totient._from_factors({ p: 1, q: 1 })  # phi(n)

d = pow(e, -1, pn)

c = 110644875422336073...
m = pow(c, d, p * q)
print(m)
print(m.to_bytes(32, "big"))
```

然后就可以拿到 flag 了。
