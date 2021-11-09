import sys
from code_gen import CodeGenerator

def gen_code(g: CodeGenerator):
    g.right(1)
    g.get(73)
    g.down(1)
    g.left(1)
    # 往锅里放菜时一次只能放下一个物品
    g.drop(1)
    g.if_ge_and_goto(1, -1)

def main():
    with CodeGenerator(sys.stdout.buffer) as g:
        gen_code(g)


if __name__ == "__main__":
    main()
