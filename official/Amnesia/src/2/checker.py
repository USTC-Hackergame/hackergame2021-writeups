import subprocess
import os
import sys

if __name__ == "__main__":
    print("Your code for Memory Erasure: (Two empty lines to end): ")
    code1 = []
    while True:
        try:
            line = input()
        except EOFError:
            break
        code1.append(line)
        if len(code1) >= 2 and code1[-1] == '' and code1[-2] == '':
            break

    os.system("rm -rf /dev/play && mkdir -m777 -p /dev/play && chmod +t /dev/play")
    with open("/dev/play/code2.c", "w") as fd1:
        for i in code1:
            fd1.write(i)
            fd1.write("\n")
        fd1.close()
    sys.stdout.flush()

    subprocess.run(
            ["su", "nobody", "-s", "/bin/bash", "-c", "/compile.sh"]
            )
    p = subprocess.run(
            ["su", "nobody", "-s", "/bin/bash", "-c", "/dev/play/a.out"],
            stdout = subprocess.PIPE,
            stdin = subprocess.DEVNULL,
            stderr = subprocess.STDOUT,
            )

    try:
        output = p.stdout.decode()
    except UnicodeDecodeError:
        print("Output decode error, non-ASCII character detected. Fail. ")
        output = "(invalid)"
    retval = p.returncode
    print("Output: ")
    print(output)
    print("Return: ")
    print(retval)
    if (retval != 0):
        print("Your code didn\'t end properly.")
    elif output == "Hello, world!" or output == "Hello, world!\n":
        print("Passed!")
        try:
            print(open("/root/flag2").read())
        except FileNotFoundError:
            print("Flag file not found! Please contact developers")
    else:
        print("Failed.")

