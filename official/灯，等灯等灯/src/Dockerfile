FROM tiangolo/uwsgi-nginx-flask

RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip3 install pyopenssl numpy scipy redis

COPY ./app /app