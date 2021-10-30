#!/usr/bin/env python
# coding: utf-8

from llvmlite import ir
import llvmlite.binding as llvm
import random
import z3
import string

llvm.initialize()
llvm.initialize_native_target()
llvm.initialize_native_asmprinter()


mba = '''(x^y)+2*(x|~y) + 2,x-y
x-y - 2*(x|~y)-2,x^y
(x|y)+y-(~x&y),x+y
(x|y)+(~x|y)-(~x),x+y
y-(~x)-1,x+y
2*(x|y)-(~x&y)-(x&~y),x+y
-(~x)-(~y)-2,x+y
(x^y)+2*y-2*(~x&y),x+y
(x^y)+2*(~x|y)-2*(~x),x+y
-(x^y)+2*y+2*(x&~y),x+y
2*y-(~x&y)+(x&~y),x+y
2*y-(~x)+(~y),x+y
y+(x&~y)+(x&y),x+y
(~x&y)+(x&~y)+2*(x&y),x+y
(x|y)-y+(~x&y),x^y
(x|y)-(~x|y)+(~x),x^y
-(~x|y)+(~x&y)-1,x^y
2*(x|y)-y-x,x^y
-(~x|y)-(x|~y)-2,x^y
-y+2*(~x&y)+x,x^y
-(~x|y)+2*(~x&y)+(x|~y),x^y
y+x-2*(x&y),x^y
y+(x&~y)-(x&y),x^y
y+(~y)-~(x^y),x^y
(~x|y)+(x&~y)-~(x^y),x^y
-(x|y)+x+y,x&y
(x|~y)+y+1,x&y
(x|y)-(~x&y)-(x&~y),x&y
-(~x&y)-(~y)-1,x&y
-(x^y)+y+(x&~y),x&y
-~(x&y)+y+~y,x&y
-~(x&y)+(~x|y)+(x&~y),x&y
(x^y)+y-(~x&y),x|y
(x^y)+(~x|y)-(~x),x|y
~(x&y)+y-(~x),x|y
x+y-(x&y),x|y
y+(x|~y)-(~(x^y)),x|y
(~x&y)+(x&~y)+(x&y),x|y
3*(x|~y)+(~x|y)-2*(~y)-2*(~(x^y)),x+y
-(x|~y)-(~x)+(x&y)-2,x+y
(x|~y)+(~x&y)-(~(x&y))+(x|y),x+y
2*(~(x^y))+3*(~x&y)+3*(x&~y)-2*(~(x&y)),x+y
-(x|~y)+(~x|y)-2*(~(x|y))+2*(~y),x^y
(x|~y)-3*(~(x|y))+2*(~x)-y,x^y
-(x|~y)+(~y)+(x&~y)+y,x^y
(x|~y)+(~x|y)-2*(~(x|y))-2*(x&y),x^y
(x|y)-(~x|y)+(~x),x^y
2*y-(~x)+(~y),x+y
2*(x|y)-y-x,x^y
-(x^y)+2*y+2*(x&~y),x+y
-(~x|y)+2*(~x&y)+(x|~y),x^y
x+y-(x&y)-2*(~x&y)+~(x|y)-~(x^y),x-y
x-2*(~x&y)+(x^y)+~(x|y)-(x|~y),x-y
x+(x^y)-(x|y)+~y-~(x&y),x-y
(~x|y)+(x&~y)-~(x^y),x^y
(x|y)-(~x&y)-(x&~y),x&y
3*(x&~y)-(~x&y)+(~x|y)-~(x&y)-x,x-y
x-3*(y&~x)+2*(x^y)-(x|y)+(y|~x)-(~y|x),x-y
-(x|~y)+(~y)+(x&~y)+y,x^y
(x|~y)+(~x|y)-2*(~(x|y))-2*(x&y),x^y
(x&y)*(x|y)+(x&~y)*(~x&y),x*y'''

x = z3.BitVec('x', 64)
y = z3.BitVec('y', 64)
mba = list(map(lambda x: x.split(','), mba.split('\n')))
dmba = {}
for a, b in mba:
    a = eval(a.strip())
    b = eval(b)
    if b not in dmba:
        dmba[b] = []
    dmba[b].append(a)


def GenerateMC(seed, hardness=2):
    rng = random.Random(seed)
    solution = "".join(rng.choices(string.ascii_letters+string.digits, k=16))

    invertable = [x+y, x-y, x ^ y]
    inverted = {x+y: x-y, x-y: x+y, x ^ y: x ^ y}

    noninvert = [x*y, x | y, x & y]

    rng.shuffle(invertable)
    rng.shuffle(noninvert)
    ops = invertable + noninvert

    if hardness == 2:
        op_obf = [rng.choice(dmba[invertable[0]])]
    else:
        op_obf = [invertable[0]]
    op_real = [x]
    last_exp = invertable[0]
    for exp in invertable[1:]:
        if hardness == 2:
            op_obf.append(z3.substitute(
                rng.choice(dmba[exp]), (x, op_obf[-1])))
        else:
            op_obf.append(z3.substitute(exp, (x, op_obf[-1])))
        op_real.append(z3.substitute(op_real[-1], (x, inverted[last_exp])))
        last_exp = exp
    for exp in noninvert:
        if hardness == 2:
            op_obf.append(z3.substitute(rng.choice(dmba[exp]), (x, op_obf[2])))
        else:
            op_obf.append(z3.substitute(exp, (x, op_obf[2])))
        op_real.append(z3.substitute(op_real[2], (x, inverted[last_exp])))

    seed = rng.randint(0, 2**32-1)
    rng2 = random.Random(seed)
    rng2.shuffle(op_obf)
    rng2 = random.Random(seed)
    rng2.shuffle(ops)
    rng2 = random.Random(seed)
    rng2.shuffle(op_real)
    opsindex = [rng.randint(0, 2**64-1) for _ in range(len(ops))]

    def exp2obf(builder, exp, a, b, depth=1):
        if exp.num_args() == 0:
            if z3.eq(exp, x):
                return a
            elif z3.eq(exp, y):
                return b
            else:
                assert z3.is_bv_value(exp)
                return int64(exp.as_long())
        elif exp.num_args() == 1:
            if z3.is_app_of(exp, z3.Z3_OP_BNOT):
                return builder.not_(exp2obf(builder, exp.children()[0], a, b, depth=depth))
            elif z3.is_app_of(exp, z3.Z3_OP_BNEG):
                return builder.neg(exp2obf(builder, exp.children()[0], a, b, depth=depth))
            elif z3.is_app_of(exp, z3.Z3_OP_INT2BV):
                return int64(exp.children()[0].as_long())
            assert(0)
        else:
            assert exp.num_args() == 2
            aa = exp2obf(builder, exp.children()[0], a, b, depth=depth)
            bb = exp2obf(builder, exp.children()[1], a, b, depth=depth)
            if depth == 0:
                if z3.is_app_of(exp, z3.Z3_OP_BADD):
                    return builder.add(aa, bb)
                elif z3.is_app_of(exp, z3.Z3_OP_BAND):
                    return builder.and_(aa, bb)
                elif z3.is_app_of(exp, z3.Z3_OP_BOR):
                    return builder.or_(aa, bb)
                elif z3.is_app_of(exp, z3.Z3_OP_BSUB):
                    return builder.sub(aa, bb)
                elif z3.is_app_of(exp, z3.Z3_OP_BXOR):
                    return builder.xor(aa, bb)
                elif z3.is_app_of(exp, z3.Z3_OP_BMUL):
                    return builder.mul(aa, bb)
                assert(0)
            for i in range(len(ops)):
                if ops[i].decl() == exp.decl():
                    k1 = rng.randint(0, 2**63-1)*2+1
                    if opsfunck == 0:
                        k2 = opsindex[i] - k1
                    if opsfunck == 1:
                        k2 = k1 - opsindex[i]
                    if opsfunck == 2:
                        k2 = (opsindex[i] * pow(k1, -1, 2**64)) % 2**64
                    if opsfunck == 3:
                        k2 = opsindex[i] ^ k1
                    return builder.call(opsfunc, (int64(k1), int64(k2), exp2obf(builder, op_real[i], aa, bb, depth=depth-1), bb))
            assert(0)

    def exp2ir(builder, exp, a, b):
        return exp2obf(builder, exp, a, b, depth=0)

    int64 = ir.IntType(64)
    module = ir.Module(name="temp")

    opsfunc = ir.Function(module, ir.FunctionType(
        int64, (int64, int64, int64, int64)), name="ops")
    block = opsfunc.append_basic_block()
    builder = ir.IRBuilder(block)
    k1, k2, a, b = opsfunc.args
    xx = builder.alloca(int64)
    kk = builder.alloca(int64)
    yy = builder.alloca(int64)
    retv = rng.choice([xx, yy])
    builder.store(a, xx)
    opsfunck = rng.randint(0, 3)
    if opsfunck == 0:
        k = builder.add(k1, k2)
    if opsfunck == 1:
        k = builder.sub(k1, k2)
    if opsfunck == 2:
        k = builder.mul(k1, k2)
    if opsfunck == 3:
        k = builder.xor(k1, k2)
    builder.store(k, kk)
    builder.store(b, yy)

    block = opsfunc.append_basic_block()
    builder.branch(block)
    builder = ir.IRBuilder(block)

    retk = rng.randint(0, 2**64-1)
    loopks = [rng.randint(0, 2**64-1)]
    loopkc = rng.randint(0, 2**63-1)*2+1
    opsloopk = rng.randint(0, 2)
    nrounds = rng.randint(8, 16)
    for i in range(nrounds):
        if opsloopk == 0:
            newpk = (loopks[-1]+loopkc) % 2**64
        if opsloopk == 1:
            newpk = (loopks[-1]-loopkc) % 2**64
        if opsloopk == 2:
            newpk = (loopks[-1]*loopkc) % 2**64
        loopks.append(newpk)

    loop = opsfunc.append_basic_block()
    with builder.goto_block(loop):
        a = builder.load(xx)
        k = builder.load(kk)
        b = builder.load(yy)
        rc0 = rng.randint(0, 2**64-1)
        rc1 = rng.randint(0, 2**64-1)
        roundexp = z3.substitute(rng.choice(invertable+[x*y]),
                                 (y, z3.Int2BV(z3.IntVal(1), 64) | z3.substitute(rng.choice(noninvert),
                                                                                 (x, z3.Int2BV(
                                                                                     z3.IntVal(rc0), 64)),
                                                                                 (y, z3.substitute(rng.choice(ops),
                                                                                                   (x, z3.Int2BV(z3.IntVal(rc1), 64)))))))
        a = exp2obf(builder, roundexp, a, b, depth=hardness)
        builder.store(b, xx)
        k = exp2obf(builder, [x+y, x-y, x*y][opsloopk],
                    k, int64(loopkc), depth=hardness)
        builder.store(k, kk)
        builder.store(a, yy)
        builder.branch(block)

    k = builder.load(kk)
    switch = builder.switch(k, loop)
    for i in range(len(ops)):
        temp = opsfunc.append_basic_block()
        switch.add_case(opsindex[i], temp)
        with builder.goto_block(temp):
            a = builder.load(xx)
            k = builder.load(kk)
            t = rng.choice(invertable)
            builder.store(
                exp2ir(builder, t,
                       int64(z3.simplify(z3.substitute(inverted[t], (x, z3.Int2BV(
                           z3.IntVal(retk), 64)), (y, z3.Int2BV(z3.IntVal(opsindex[i]), 64)))).as_long()),
                       k), kk)
            b = builder.load(yy)
            result = exp2ir(builder, op_obf[i], a, b)
            builder.store(result, retv)
            builder.branch(block)

    aa = int.from_bytes(solution[:8].encode(), "little")
    bb = int.from_bytes(solution[8:].encode(), "little")
    for i in range(nrounds):
        aa, bb = bb,  z3.simplify(z3.substitute(roundexp, (x, z3.Int2BV(
            z3.IntVal(aa), 64)), (y, z3.Int2BV(z3.IntVal(bb), 64)))).as_long()

    temp = opsfunc.append_basic_block()
    switch.add_case(loopks[-1], temp)
    with builder.goto_block(temp):
        rca = rng.randint(0, 2**63-1)*2+1
        rcb = rng.randint(0, 2**63-1)*2+1
        checkops = rng.sample([x*y, x | y, x & y], 2)
        a = builder.load(xx)
        k = builder.load(kk)
        t = rng.choice(invertable)
        builder.store(
            exp2ir(builder, t,
                   int64(z3.simplify(z3.substitute(inverted[t], (x, z3.Int2BV(
                       z3.IntVal(retk), 64)), (y, z3.Int2BV(z3.IntVal(loopks[-1]), 64)))).as_long()),
                   k), kk)
        b = builder.load(yy)
        builder.store(builder.select(
            builder.and_(
                builder.and_(builder.icmp_unsigned('==',
                                                   exp2obf(
                                                       builder, checkops[0], a, int64(rca), depth=hardness),
                                                   int64(z3.simplify(z3.substitute(checkops[0], (x, z3.Int2BV(z3.IntVal(aa), 64)), (y, z3.Int2BV(z3.IntVal(rca), 64)))).as_long())),
                             builder.icmp_unsigned('==',
                                                   exp2obf(
                                                       builder, checkops[1], a, int64(rca), depth=hardness),
                                                   int64(z3.simplify(z3.substitute(checkops[1], (x, z3.Int2BV(z3.IntVal(aa), 64)), (y, z3.Int2BV(z3.IntVal(rca), 64)))).as_long()))),
                builder.and_(builder.icmp_unsigned('==',
                                                   exp2obf(
                                                       builder, checkops[0], b, int64(rcb), depth=hardness),
                                                   int64(z3.simplify(z3.substitute(checkops[0], (x, z3.Int2BV(z3.IntVal(bb), 64)), (y, z3.Int2BV(z3.IntVal(rcb), 64)))).as_long())),
                             builder.icmp_unsigned('==',
                                                   exp2obf(
                                                       builder, checkops[1], b, int64(rcb), depth=hardness),
                                                   int64(z3.simplify(z3.substitute(checkops[1], (x, z3.Int2BV(z3.IntVal(bb), 64)), (y, z3.Int2BV(z3.IntVal(rcb), 64)))).as_long())))
            ), int64(0), int64(1)), retv)
        builder.branch(block)

    retblock = opsfunc.append_basic_block()
    switch.add_case(retk, retblock)
    with builder.goto_block(retblock):
        builder.ret(builder.load(retv))

    checkfunc = ir.Function(module, ir.FunctionType(
        int64, (int64, int64)), name="check")
    block = checkfunc.append_basic_block()
    builder = ir.IRBuilder(block)
    a, b = checkfunc.args
    k1 = rng.randint(0, 2**63-1)*2+1
    if opsfunck == 0:
        k2 = loopks[0] - k1
    if opsfunck == 1:
        k2 = k1 - loopks[0]
    if opsfunck == 2:
        k2 = (loopks[0] * pow(k1, -1, 2**64)) % 2**64
    if opsfunck == 3:
        k2 = loopks[0] ^ k1
    builder.ret(builder.call(opsfunc, (int64(k1), int64(k2), a, b)))

    mod = llvm.parse_assembly(str(module))
    mod.verify()

    target = llvm.Target.from_default_triple()
    target_machine = target.create_target_machine(opt=1, codemodel='small')
    return solution, target_machine.emit_object(mod)
