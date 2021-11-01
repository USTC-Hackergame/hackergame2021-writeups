# HackerGame 2021 WP

By [EarthC](https://github.com/EarthCompass)

## 灯，等灯等灯

### Level 0

GF(256) 上面解方程即可

### Level 1 / Level 2

一开始还在想怎么线性规划（？），后来突然意识到，这道题目跟[LWE](https://en.wikipedia.org/wiki/Learning_with_errors)不是一样一样的吗？

原题就成了一个GF(256)上的LWE问题，构造格求解CVP，代码参考https://gist.github.com/hakatashi/2266a5df35cc79de50b86d2419b33a6f

这里放一个解Level 2的代码, Level 1算法完全一致，只需要换一下数据。

```python
blacklist = [(2,2),(3,2),(4,2),(4,3),(2,4),(3,4),(4,4),(4,7),(4,8),(3,8),(2,8),(2,9),(7,2),(7,3),(7,4),(8,3),(9,3),(7,7),(7,8),(7,9),(8,7),(9,7),(9,8),(9,9)]
clicks = []
mmap = [0]*144
for i in range(12):
    for j in range(12):
        if (i,j) not in blacklist:
            tmp = var(f'x_{i}_{j}')
            clicks.append(tmp)
            mmap[12*i+j] = tmp

def get_click(x,y):
    if x>=0 and x<12 and y>=0 and y < 12 and (x,y) not in blacklist:
        return mmap[12*x+y]
    else:
        return 0

ftarget = [189,189,189,189,189,33,33,33,189,189,189,189,189,189,189,33,33,33,189,33,44,189,189,189,189,189,189,189,189,33,33,33,33,189,189,189,189,189,189,189,189,33,189,33,33,189,189,189,189,189,189,33,33,189,189,33,33,33,189,189,189,134,33,33,189,189,189,189,33,33,189,189,189,144,33,33,189,189,189,189,33,189,189,189,189,142,33,33,189,189,189,189,33,33,33,189,189,100,142,33,189,189,189,189,33,33,33,189,189,142,142,189,189,189,189,189,189,33,189,189,189,59,142,33,189,189,189,189,33,189,189,189,189,189,33,33,189,189,189,189,189,189,189,189]
mm = []
for i in range(12):
    for j in range(12):
        data = 0
        data += 31*get_click(i,j)
        data += 63*get_click(i-1,j)
        data += 63*get_click(i+1,j)
        data += 63*get_click(i,j-1)
        data += 63*get_click(i,j+1)
        
        data += 63*get_click(i+1,j+1)
        data += 63*get_click(i+1,j-1)
        data += 63*get_click(i-1,j+1)
        data += 63*get_click(i-1,j-1)
        
        data += 127*get_click(i-2,j-2)
        data += 127*get_click(i-2,j-1)
        data += 127*get_click(i-2,j)
        data += 127*get_click(i-2,j+1)
        data += 127*get_click(i-2,j+2)
        data += 127*get_click(i-1,j+2)
        data += 127*get_click(i,j+2)
        data += 127*get_click(i+1,j+2)
        data += 127*get_click(i+2,j+2)
        data += 127*get_click(i+2,j+1)
        data += 127*get_click(i+2,j)
        data += 127*get_click(i+2,j-1)
        data += 127*get_click(i+2,j-2)
        data += 127*get_click(i+1,j-2)
        data += 127*get_click(i,j-2)
        data += 127*get_click(i-1,j-2)
        
        coeff = []
        for c in clicks:
            coeff.append(data.coefficient(c))
        mm.append(coeff)
from sage.modules.free_module_integer import IntegerLattice

# Babai's Nearest Plane algorithm
# from: http://mslc.ctf.su/wp/plaidctf-2016-sexec-crypto-300/
def Babai_closest_vector(M, G, target):
    small = target
    for _ in range(1):
        for i in reversed(range(M.nrows())):
            c = ((small * G[i]) / (G[i] * G[i])).round()
            small -= M[i] * c
    return target - small

n = 144-len(blacklist)
m = 144
q = 256

b_values = ftarget
A_values = mm

A = matrix(ZZ, m + n, m)
for i in range(m):
    A[i, i] = q
for x in range(m):
    for y in range(n):
        A[m + y, x] = A_values[x][y]
lattice = IntegerLattice(A, lll_reduce=True)
print("LLL done")
gram = lattice.reduced_basis.gram_schmidt()[0]
target = vector(ZZ, b_values)
res = Babai_closest_vector(lattice.reduced_basis, gram, target)
print("Closest Vector: {}".format(res))

R = IntegerModRing(q)
M = Matrix(R, A_values)
ingredients = M.solve_right(res)

print("Ingredients: {}".format(ingredients))
print("ok")
cnt = 0
ans = mmap.copy()
for i in range(144):
    if ans[i] != 0:
        ans[i] = ingredients[cnt]
        cnt+=1
print(ans)
        
```

## 超 OI 的 Writeup 模拟器

### 果然还是逆向比较简单 / 这次没人两小时手做吧

angr全自动

```python
def solve(level):
	p = angr.Project(f'challs/{level}.bin',auto_load_libs=False)

	cfg = p.analyses.CFGFast()
	print(p)

	target_addr = 0
	for addr,b in cfg.kb.functions.items():
		if b.returning and len(list(b.blocks)) == 2 and b.has_return:
			print("*"*30)

			target_addr = addr

	a = claripy.BVS('r0',64)
	b = claripy.BVS('r1',64)
	add_opt = {
		# angr.options.ZERO_FILL_UNCONSTRAINED_REGISTERS,
		# angr.options.ZERO_FILL_UNCONSTRAINED_MEMORY,
		# angr.options.LAZY_SOLVES,
		# angr.options.UNICORN,
		# angr.options.DOWNSIZE_Z3,
		# angr.options.SIMPLIFY_CONSTRAINTS
	}
	rm_opt = {
		angr.options.SIMPLIFY_MEMORY_WRITES,
		angr.options.SIMPLIFY_REGISTER_WRITES,
	}
	state = p.factory.call_state(target_addr,a,b,add_options=add_opt,remove_options=rm_opt)


	simgr = p.factory.simgr(state)
	start_time = time.time()
	simgr.explore(find=target_addr+33)
	print(f"Done in {time.time()-start_time}")

	end = simgr.found[0]

	print("Solving。。")
	try:
		s = b''
		s+=end.solver.eval(a).to_bytes(8,byteorder='little')
		s+=end.solver.eval(b).to_bytes(8,byteorder='little')

		print(level,s.decode())

	except Exception as e:
		print("error",level)
		print(e)
```

### 什么叫无情的逆向机器

angr的默认选项会在执行途中尝试化简表达式，导致大部分样本执行时间爆炸，可以手动关闭相关选项加速符号执行（虽然表达式会巨复杂）。

但是z3只能解出少部分题目，剩下的大多数bin会unsat无解。

过于复杂求解卡住还可以理解，但是不知道为啥会unsat，希望大佬教教。

