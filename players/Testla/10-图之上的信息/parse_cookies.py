# https://stackoverflow.com/a/32281245
from http.cookies import SimpleCookie as sc
c = sc()
c.load('session=...')
d = {}
for key, morsel in c.items():
    d[key] = morsel.value
print(d)
