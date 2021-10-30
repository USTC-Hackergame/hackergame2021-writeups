FROM ustclug/debian:10
RUN apt update && apt -y upgrade && \
    apt install -y gcc=4:8.3.0-1 gcc-multilib=4:8.3.0-1 xxd python3 && \
    rm -rf /var/lib/apt/lists/*
COPY checker.py /
COPY compile.sh /
CMD ["python3", "/checker.py"]
