import sys
from code_gen import CodeGenerator

def gen_code(g: CodeGenerator):
    g.right(1)
    g.get(1)
    g.down(1)
    g.left(1)
    g.drop(1)
    g.right(2)
    g.up(1)
    g.get(1)
    g.down(1)
    g.left(2)
    g.drop(1)

def main():
    with CodeGenerator(sys.stdout.buffer) as g:
        gen_code(g)


if __name__ == "__main__":
    main()
