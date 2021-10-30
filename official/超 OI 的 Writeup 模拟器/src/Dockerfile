FROM tiangolo/uwsgi-nginx-flask

RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip3 install pyopenssl redis llvmlite z3-solver

COPY ./app /app

RUN gcc -c -o /app/check.o /app/check.c