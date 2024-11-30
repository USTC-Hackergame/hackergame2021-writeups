# 超 OI 的 Writeup 模拟器

题解作者：[djh](https://github.com/emc2314)

出题人、验题人、文案设计等：见 [Hackergame 2021 幕后工作人员](../../credits.pdf)。

## 题目描述

- 题目分类：binary

- 题目分值：果然还是逆向比较简单（150）+ 这次没人两小时手做吧（200）+ 什么叫无情的逆向机器（300）

- 题目链接：[http://202.38.93.111:13768/login?token={token}](http://202.38.93.111:13768/login)

书接上回，Hackergame 2020 圆满落幕后，各路选手纷纷好评：

> 选手 C：又是一年 Hackergame，题目依然高质量，依然对萌新友好，各种梗也依然玩得飞起。

> 选手 G：有一些很有趣的题目，但是可能需要一些基础。(虽然数理模拟器真的不是什么好回忆)

> 选手 S：我有一个绝妙的解法，可惜我号太少，说不出来！

出题人正沉浸在这些有趣的反馈中，突然注意到群里的一条新消息：

> 选手 M：纯萌新，不懂就问，只有我读不懂某位高排名选手 Writeup 中的 C++ 代码吗？

古道热肠的出题人迅捷而准确地定位到了选手 M 口中的 Writeup 代码。定睛一看，其中充斥着各样精妙繁复的宏定义与模板类（此等混淆传闻只曾在 OI 竞赛中出现过）。不过，身为一名成熟的 Hackergame 出题人，当年即使面对着 [IOCCC](https://www.ioccc.org/) 的获奖代码，也未尝有丝毫的慌乱。于是在一阵紧促的键盘敲击声后，出题人熟练地把 Writeup 中的代码下载编译，并成功用 IDA 打开。

只可惜——

“这是怎么一回事？”，出题人想，把眼睛睁得有碗口那么大。

“我什么算法也看不懂！”但是他不敢把这句话说出来。

群里的那位选手 M 还在请求群友能够为其答疑解惑，同时问道，条件跳转是不是很精致，循环是不是很漂亮。

这位可怜的出题人眼睛越睁越大，可是他还是看不懂其中的算法，因为的确看不懂。

“我的老天爷！”他想。“难道我也是一个萌新吗？我从来没有怀疑过我自己。我决不能让人知道这件事。难道我不是一个称职的出题人吗？不成；我决不能让人知道我看不懂这个算法。”

于是出题人定了定神，假装读懂了代码之后，在群里耐心地回复了选手 M：

> 确实只有萌新才读不懂。

抢在萌新继续追问之前，出题人赶紧劝道：

> 当然，要读懂 OI 选手撰写的 Writeup 可是需要相当水准的，绝非一朝一夕之功。授人以鱼不若授人以渔，如此这般，明年的 Hackergame 2021，就由本出题人亲手打造一款模拟 OI 选手 Writeup 风格的代码混淆器。请君且闭关修练一年，待到彼时，神功大成，如若能够通过模拟器的测试，回头再来参悟这篇代码，方才有丝毫读懂的可能啊。

好在这位萌新从谏如流：

> 善。

出题人长舒一口气，瘫进躺椅，闭上眼睛开始构思自己明年的出题计划。

## 题解
这道题的二进制文件全部动态生成（[核心生成代码](src/app/generate.py)）。混淆分为三个级别，主要用到的混淆方法有：Function Merging，Control Flow Flattening 以及 Mixed Boolean Arithmetic，相当于手动实现了我自己写的一个 [LLVM 混淆框架](https://github.com/emc2314/YANSOllvm/)（其中有许多原创混淆 Pass，欢迎 Star，~~不过似乎好久没更新了~~）的一小部分功能。前两个级别的主要作用是帮助选手了解最后一问中的代码混淆前的大致结构，故此处不做题解。

验证的核心过程是一个类似于 Feistel 结构的数据变换。众所周知 Feistel 结构不要求轮函数可逆，所以其实只需要提取出算法的输出数据，反向调用轮函数即可还原。

题目要求 256 次逆向（~~这次应该不会有人因为手做而体验极差了吧~~），所以很明显我们需要自动化。对于二进制逆向许多框架，包括 IDA，GHIDRA，angr，BARF，BAP，MIASM2 等等，以及一些不太成熟的新产物比如 B2R2，和其他动态分析的如 QDBI，DynamoRIO，Triton 等等。这里题解使用了 Binary Ninja 作为分析工具，因为写脚本比 IDA 更方便且文档相对易读，而对比其他开源项目（除 Ghidra 外）其反编译质量又明显更高。缺点是需要购买正版，且价格并不亲民。但是其实各种工具都大同小异，主要解题思路较通用，故以下脚本可做参考：

```python
import z3
# qiling 是一个基于 unicorn 的二进制模拟框架，近年逐渐成熟可用
import qiling
import random
import requests


# 这个地方是为了修复 qiling 处理 IO 的一个 bug
open('ida_idaapi.py','w').write('')


import binaryninja as bn

class StringBuffer:
    def __init__(self):
        self.buffer = b''

    def read(self, n):
        ret = self.buffer[:n]
        self.buffer = self.buffer[n:]
        return ret

    def readline(self, end=b'\n'):
        ret = b''
        while True:
            c = self.read(1)
            ret += c
            if c == end:
                break
        return ret

    def write(self, string):
        self.buffer += string
        return len(string)


session = requests.session()

# 作者的 token，无妨泄漏
burp0_url = "http://202.38.93.111:13768/login?token=222%3AMEUCIQDRMmwIj8lK7kkxTTqg%2FNhsfp6rrooObAaGWgzq9j85bAIgfNlhpJT8OE2GEsHWsKvSWmynuOYWp3zqZ%2Fxn%2Bg19s4s%3D"
burp0_headers = {"Upgrade-Insecure-Requests": "1", "DNT": "1", "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.81 Safari/537.36", "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9", "Referer": "http://202.38.93.111:13768/login", "Accept-Encoding": "gzip, deflate", "Accept-Language": "en-US,en;q=0.9,zh-TW;q=0.8,zh-CN;q=0.7,zh;q=0.6", "Connection": "close"}
session.get(burp0_url, headers=burp0_headers)

for i in range(16,256):
    print(i)
    wslpath = f"bins/{i}.bin"
    r=session.get(f"http://202.38.93.111:13768/challenge/{i}.bin")
    open(wslpath,"wb").write(r.content)

    binv = bn.BinaryViewType['ELF'].open(wslpath)
    binv.update_analysis_and_wait()

    for func in binv.functions:
        if func.name == 'main':
            mainfunc = func
            break


    # 先跑起来一个 qiling 的模拟程序，让它停在 main 之前，相当于把内存和 glibc 的初始化都完成了
    ql = qiling.Qiling([wslpath],'/', stdin=StringBuffer(),stdout=StringBuffer(),stderr=StringBuffer(),console=False)
    base = int(ql.profile.get('OS64','load_address'), 16)
    ql.run(end=base+mainfunc.start)

    # 这里主要在找核心验证流程函数（虽然因为编译的原因其地址似乎不会改变），试图写鲁棒一些
    for il in mainfunc.mlil.ssa_form[list(mainfunc.mlil.ssa_form)[0][-1].operands[2]].il_basic_block:
        if il.operation == bn.MediumLevelILOperation.MLIL_CALL_SSA:
            check = il.operands[1]
            break
    for bb in binv.get_function_at(check.constant).mlil.ssa_form:
        for il in bb:
            if il.operation == bn.MediumLevelILOperation.MLIL_CALL_SSA:
                ops = il.operands[1]
                callops = il
                break


    # 修复 binary ninja 的一个分析 bug
    opsfunc = binv.get_function_at(ops.constant)
    opsfunc.set_user_type(str(opsfunc))
    binv.update_analysis_and_wait()


    # HLIL 接近于 C 代码了，相当高层并且优化较多。一般而言二进制分析会使用 MLIL
    # 这种 Middle Level 的 IR，但是本题用 HLIL 更方便。
    # 这一段的意思很简单，为了找到两个关键的 Basic Block。一个是验证最终结果是否等于预置的结果，
    # 一个是输入数据的处理流程。它们都有调用自己函数的特征，再通过是否包含比较操作符加以区分。
    for bb in opsfunc.hlil:
        callFlag = False
        cmpFlag = False
        for il in bb:
            if il.operation == bn.HighLevelILOperation.HLIL_VAR_INIT:
                if il.operands[1].operation == bn.HighLevelILOperation.HLIL_CALL:
                    if il.operands[1].operands[0].constant == ops.constant:
                        callFlag = True
            elif il.operation == bn.HighLevelILOperation.HLIL_ASSIGN:
                if il.operands[1].operation == bn.HighLevelILOperation.HLIL_CMP_NE:
                    cmpFlag = True
        if callFlag:
            if bb[0].operation == bn.HighLevelILOperation.HLIL_LABEL:
                t = bb[1:]
            else:
                t = bb
            if cmpFlag:
                rblock = t
            else:
                pblock = t


    # 下面一段是找到关键的变量和它对应的操作以及结果比较
    def find_var(il):
        if il.operation == bn.HighLevelILOperation.HLIL_VAR:
            return il.operands[0]
        elif il.operation == bn.HighLevelILOperation.HLIL_CALL:
            a = find_var(il.operands[1][2])
            b = find_var(il.operands[1][3])
            if a:
                return a
            else:
                return b
        elif il.operation == bn.HighLevelILOperation.HLIL_CONST:
            return None
        else:
            a = find_var(il.operands[0])
            b = find_var(il.operands[1])
            if a:
                return a
            else:
                return b

    def process_or(il):
        if il.operation == bn.HighLevelILOperation.HLIL_OR:
            process_or(il.operands[0])
            process_or(il.operands[1])
            return
        elif il.operation == bn.HighLevelILOperation.HLIL_XOR:
            rdict[il.operands[0].operands[0]].append(il.operands[1].constant)
            return
        print(il)
        assert(0)

    rdict = {}
    xorvar = {}
    if rblock[1].operands[1].operation == bn.HighLevelILOperation.HLIL_XOR:
        xorvar = {rblock[1].operands[0]: rblock[1].operands[1].operands[0].operands[0],
            rblock[2].operands[0]: rblock[2].operands[1].operands[0].operands[0]}
        for il in rblock[3:7]:
            rdict[il.operands[0]] = [il.operands[1].operands[1][-1].constant,
                find_var(il.operands[1])]
        process_or(rblock[8].operands[1].operands[0])
    else:
        for il in rblock[1:5]:
            rdict[il.operands[0]] = [il.operands[1].operands[1][-1].constant,
                find_var(il.operands[1])]
        assert rblock[6].operation == bn.HighLevelILOperation.HLIL_ASSIGN
        process_or(rblock[6].operands[1].operands[0])

    # 在 qiling 的模拟器中模拟执行函数，获取输出
    def opscall(args):
        ql.reg.rip = base+callops.address
        for i in range(4):
            exec(f"ql.reg.{opsfunc.calling_convention.int_arg_regs[i]} = {args[i]}")
        ql.run(begin=ql.reg.rip,end=base+callops.address+binv.get_instruction_length(callops.address))
        return ql.reg.rax


    # 把函数调用作为黑盒，把变量替换为随机的常数，
    # 得到输入输出对之后可以进行 Program Sythesize。这也是目前解决 MBA 的常见方法。
    def sample_il(il,subs):
        if il.operation == bn.HighLevelILOperation.HLIL_CALL:
            args =[il.operands[1][0].constant,il.operands[1][1].constant]
            args.append(sample_il(il.operands[1][2],subs))
            args.append(sample_il(il.operands[1][3],subs))
            return opscall(args)
        elif il.operation == bn.HighLevelILOperation.HLIL_CONST:
            if il.constant in subs:
                return subs[il.constant]
            else:
                return il.constant
        elif il.operation == bn.HighLevelILOperation.HLIL_SUB:
            return sample_il(il.operands[0],subs) - sample_il(il.operands[1],subs)
        elif il.operation == bn.HighLevelILOperation.HLIL_ADD:
            return sample_il(il.operands[0],subs) + sample_il(il.operands[1],subs)
        elif il.operation == bn.HighLevelILOperation.HLIL_XOR:
            return sample_il(il.operands[0],subs) ^ sample_il(il.operands[1],subs)
        elif il.operation == bn.HighLevelILOperation.HLIL_VAR:
            return subs[il.operands[0]]
        assert(0)


    # 这里偷懒没有零先验知识地去 synthesize，而是假设其操作一定为 *+-^| 这几个操作符。
    # 如果不偷懒的话可以用 Syntia（python2 语言，基于 MCTS）或者
    # Xyntia（不开源，但是免费提供二进制）等论文中的方法。
    def z3op(op,i1,i2):
        return z3.If(op == 0, i1 & i2, z3.If(op == 1, i1 | i2, z3.If(op == 2, i1 ^ i2, z3.If(op == 3, i1 * i2,
                z3.If(op == 4, i1 + i2, i1 - i2)))))

    def z3int(i):
        return z3.Int2BV(z3.IntVal(i),64)


    # 因为知道它的操作只有几种可能，故而可以直接通过 z3 把要求的数据和
    # 要 synthesize 的操作一并求出来。
    solver = z3.Solver()

    for i in range(1, 5):
        op = z3.BitVec(f'op_{i}', 3)
        if xorvar:
            il = rblock[i+2]
        else:
            il = rblock[i]
        var,il = il.operands
        cst, var, result = rdict[var]
        iodict = {var:0,cst:0}
        for _ in range(4):
            i1 = random.randint(0,2**64-1)
            i2 = random.randint(0,2**64-1)
            if xorvar:
                iodict[var] = i1 ^ i2
            else:
                iodict[var] = i1
            iodict[cst] = i2
            rr = sample_il(il,iodict)
            i1 = z3int(i1)
            i2 = z3int(i2)
            solver.add(z3op(op,i1,i2) == z3int(rr))
        if xorvar:
            solver.add(z3op(op,z3.BitVec(xorvar[var].name,64),z3int(cst)) == z3int(result))
        else:
            solver.add(z3op(op,z3.BitVec(var.name,64),z3int(cst)) == z3int(result))
    solver.check()

    # 至此，我们拿到了输入变换之后拿来比较的数据，先在要根据输出反推输入
    x = pblock[4].operands[0].operands[0]
    xv = solver.model()[z3.BitVec(x.name,64)].as_long()
    y = pblock[4].operands[1].operands[0]
    yv = solver.model()[z3.BitVec(y.name,64)].as_long()


    # Feistel 结构，但是轮数不太固定，最多 16 轮，我们遇到疑似 flag 的结果就用 qiling 验证一遍
    succ = False
    for _ in range(16):
        lastr = y
        lastv = xv
        # 把轮函数相关的 3 条 HLIL 指令用 qiling 模拟一边即可，不用花心思去逆向了
        for i in range(3):
            var, il = pblock[i].operands
            lastv = sample_il(il, {lastr:lastv})
            lastr = var
        # 这个地方需要 synthesize 一下因为不知道轮函数的结构是怎么加到另一半数据上面的
        solver = z3.Solver()
        iodict = {x:0,lastr:0}
        for _ in range(4):
            i1 = random.randint(0,2**64-1)
            i2 = random.randint(0,2**64-1)
            iodict[x] = i1
            iodict[lastr] = i2
            rr = sample_il(pblock[3].operands[1],iodict)
            i1 = z3int(i1)
            i2 = z3int(i2)
            solver.add(z3op(op,i1,i2) == z3int(rr))
        solver.add(z3op(op,z3.BitVec(x.name, 64),z3int(lastv)) == z3int(yv))
        solver.check()
        yv = xv
        xv = solver.model()[z3.BitVec(x.name,64)].as_long()
        try:
            bs = int.to_bytes(xv,8,'little')+int.to_bytes(yv,8,'little')
            bs = bs.decode('ascii')
            # 用 qiling 验证 flag 是否正确
            ql2 = qiling.Qiling([wslpath],'/', stdin=StringBuffer(),stdout=StringBuffer(),stderr=StringBuffer(),console=False)
            ql2.os.stdin.write((bs+'\n').encode())
            ql2.run()
            if b'Correct code' in ql2.os.stdout.read(-1):
                succ = True
                print(bs)
                break
        except:
            pass

    assert(succ)
    # 这里放提交代码，偷懒没写，但是自己账号下的 240 个二进制都跑过一遍了

```

