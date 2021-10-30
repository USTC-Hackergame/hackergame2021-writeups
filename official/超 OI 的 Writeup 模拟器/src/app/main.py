import OpenSSL
import base64
import hashlib
import redis
import subprocess
import tempfile

from functools import wraps
from io import BytesIO
from flask import (Flask, request, session, redirect,
                   url_for, render_template, make_response)
from flask.helpers import send_file

from generate import GenerateMC


app = Flask(__name__)
app.secret_key = b')M.I]ch3sYzGN1c-'

with open("cert.pem") as f:
    cert = OpenSSL.crypto.load_certificate(
        OpenSSL.crypto.FILETYPE_PEM, f.read())

if __name__ == '__main__':
    r = redis.StrictRedis(host='localhost', port=6379, db=0)
else:
    r = redis.StrictRedis(host='redis', port=6379, db=0)

lv0 = 1
lv1 = 16
lv2 = 256


def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'token' not in session:
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function


@app.route('/login')
def login():
    try:
        token = request.args.get('token')
        id, sig = token.split(":", 1)
        sig = base64.b64decode(sig, validate=True)
        OpenSSL.crypto.verify(cert, sig, id.encode(), "sha256")
        session['token'] = token
        session['level'] = 0
        return redirect(url_for('index'))
    except Exception:
        return make_response(render_template("error.html"), 403)

@app.route('/logout')
def logout():
    session.pop('token', None)
    session.pop('level', None)
    return redirect(url_for('login'))


@app.route('/')
@login_required
def index():
    try:
        result = request.args['result']
    except:
        result = None
    level = session['level']
    token = session['token']
    flag0 = None
    flag1 = None
    flag2 = None
    if level < lv0:
        total = lv0
    else:
        flag0 = f"flag{{ESREVER_{hashlib.sha256(('QtWID2Ip_RE!RE!lv.0'+token).encode()).hexdigest()[:16]}}}"
        if level < lv1:
            total = lv1
        else:
            flag1 = f"flag{{Half_Bl00d_Automata_{hashlib.sha256(('CldOUaYT_RE!RE!lv.1'+token).encode()).hexdigest()[:16]}}}"
            total = lv2
            if level == lv2:
                flag2 = f"flag{{RERERE_{hashlib.sha256(('8vGRUxjv_RE!RE!lv.2'+token).encode()).hexdigest()[:16]}}}"

    width = (level / float(total)) * 100
    return make_response(render_template("index.html",
                                         width=width,
                                         remaining=total-level,
                                         level=level,
                                         flag0=flag0,
                                         flag1=flag1,
                                         flag2=flag2,
                                         result=result
                                         ))


def generate_challenge(id, level):
    if level < lv0:
        hardness = 0
    elif level >= lv0 and level < lv1:
        hardness = 1
    else:
        hardness = 2

    sol, mc = GenerateMC(hashlib.sha256(f"{id}_{level}_dvZ5I2AeI3YW".encode()).digest(),
                         hardness=hardness)
    r.set(f'{id}-{level}-sol', sol)
    with tempfile.TemporaryDirectory() as tmpdirname:
        open(f"{tmpdirname}/b.o", "wb").write(mc)
        subprocess.run(
            ['gcc', '-s', '-o', f'{tmpdirname}/a.out', f'{tmpdirname}/b.o', 'check.o'])
        chal = open(f"{tmpdirname}/a.out", "rb").read()
        r.set(f'{id}-{level}-chal', chal)
    return sol.encode(), chal


@app.route('/submit', methods=['POST'])
@login_required
def submit():
    ans = request.form['ans']
    token = session['token']
    level = session['level']
    id, sig = token.split(":", 1)
    if not r.set(id+"-submit", "submit", ex=5, nx=True):
        return redirect(url_for('index', result="Rate"))
    result = 'False'
    if level < lv2:
        sol = r.get(f'{id}-{level}-sol')
        if not sol:
            sol, _ = generate_challenge(id, level)
        if sol == ans.encode():
            session['level'] = level + 1
            result = 'True'
    return redirect(url_for('index', result=result))


@app.route('/challenge/<level>.bin')
@login_required
def challenge(level):
    try:
        level = int(level)
        assert level >= 0 and level < lv2
    except:
        return make_response('参数错误', 403)

    token = session['token']
    id, sig = token.split(":", 1)
    chal = r.get(f'{id}-{level}-chal')
    if not chal:
        _, chal = generate_challenge(id, level)
    return send_file(BytesIO(chal), as_attachment=True,
                     attachment_filename=f"{level}.bin",
                     mimetype="application/octet-stream")


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
