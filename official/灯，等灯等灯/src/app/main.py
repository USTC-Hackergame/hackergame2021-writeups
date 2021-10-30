import OpenSSL
import base64
import hashlib
import ast
import numpy as np
import scipy.signal
import redis

from functools import wraps

from flask import (
    Flask,
    request,
    session,
    redirect,
    url_for,
    render_template,
    make_response,
)

app = Flask(__name__, static_folder="web",
            static_url_path="", template_folder="web")
app.secret_key = b"CO@y0rjAtzXo+g:)"

if __name__ == '__main__':
    r = redis.StrictRedis(host='localhost', port=6379, db=0)
else:
    r = redis.StrictRedis(host='redis', port=6379, db=0)

with open("cert.pem") as f:
    cert = OpenSSL.crypto.load_certificate(
        OpenSSL.crypto.FILETYPE_PEM, f.read())

target = np.array(
    [
        [189, 189, 189, 189, 189, 33, 33, 33, 189, 189, 189, 189],
        [189, 189, 189, 33, 33, 33, 189, 33, 44, 189, 189, 189],
        [189, 189, 189, 189, 189, 33, 33, 33, 33, 189, 189, 189],
        [189, 189, 189, 189, 189, 33, 189, 33, 33, 189, 189, 189],
        [189, 189, 189, 33, 33, 189, 189, 33, 33, 33, 189, 189],
        [189, 134, 33, 33, 189, 189, 189, 189, 33, 33, 189, 189],
        [189, 144, 33, 33, 189, 189, 189, 189, 33, 189, 189, 189],
        [189, 142, 33, 33, 189, 189, 189, 189, 33, 33, 33, 189],
        [189, 100, 142, 33, 189, 189, 189, 189, 33, 33, 33, 189],
        [189, 142, 142, 189, 189, 189, 189, 189, 189, 33, 189, 189],
        [189, 59, 142, 33, 189, 189, 189, 189, 33, 189, 189, 189],
        [189, 189, 33, 33, 189, 189, 189, 189, 189, 189, 189, 189],
    ],
    dtype=np.uint8,
)

weights = [
    np.array(
        [
            [0, 0, 1, 0, 0],
            [0, 0, 2, 0, 0],
            [1, 2, 3, 2, 1],
            [0, 0, 2, 0, 0],
            [0, 0, 1, 0, 0],
        ],
        np.uint8,
    ),
    np.array(
        [
            [0, 0, 1, 0, 0],
            [0, 0, 2, 0, 0],
            [1, 2, 3, 2, 1],
            [0, 0, 2, 0, 0],
            [0, 0, 1, 0, 0],
        ],
        np.uint8,
    ),
    np.array(
        [
            [127, 127, 127, 127, 127],
            [127, 63, 63, 63, 127],
            [127, 63, 31, 63, 127],
            [127, 63, 63, 63, 127],
            [127, 127, 127, 127, 127],
        ],
        np.uint8,
    ),
]

excluded = [
    [],
    [26, 38, 50, 39, 40, 52, 28, 115, 116, 117, 105, 103, 91, 79, 80, 81],
    [
        26,
        28,
        32,
        33,
        38,
        40,
        44,
        50,
        51,
        52,
        55,
        56,
        86,
        87,
        88,
        91,
        92,
        93,
        99,
        103,
        111,
        115,
        116,
        117,
    ],
]

thresholds = [0, 400, 600]


def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "token" not in session:
            return redirect(url_for("login"))
        return f(*args, **kwargs)

    return decorated_function


@app.route("/login")
def login():
    try:
        token = request.args.get("token")
        id, sig = token.split(":", 1)
        sig = base64.b64decode(sig, validate=True)
        OpenSSL.crypto.verify(cert, sig, id.encode(), "sha256")
        session["token"] = token
        return redirect(url_for("index"))
    except Exception:
        return make_response(render_template("error.html"), 403)


@app.route("/logout")
def logout():
    session.pop("token", None)
    return redirect(url_for("login"))


@app.route("/")
@login_required
def index():
    return make_response(render_template("index.html"))


@app.route("/submit", methods=["POST"])
@login_required
def submit():
    token = session["token"]
    id, sig = token.split(":", 1)
    if not r.set(id+"-submit", "submit", ex=5, nx=True):
        return make_response("两次提交请间隔 5 秒")

    try:
        level = request.form["level"]
        level = int(level)
        assert level >= 0 and level <= 2
        solution = request.form["solution"].replace(" ", "")
        assert len(solution) <= 12 * 12 * 6
        solution = ast.literal_eval(solution)
        assert len(solution) == 12
        assert all(len(x) == 12 for x in solution)
        for y in solution:
            assert all(isinstance(x, int) for x in y)

        for ex in excluded[level]:
            x, y = ex // 12, ex % 12
            if solution[x][y] != 0:
                return make_response(f"方块 ({x}, {y}) 禁止触碰!")

        clicks = np.asarray(solution, np.uint8)
        conv = scipy.signal.convolve2d(clicks, weights[level], "same")
        score = int(np.abs(conv.astype(np.int32) - target).sum())
    except:
        return make_response("非法输入")

    if not r.set(f"{id}-best-{level}", score, nx=True):
        personal_best = int(r.get(f"{id}-best-{level}"))
        if score < personal_best:
            r.set(f"{id}-best-{level}", score)
            personal_best = score
    else:
        personal_best = score

    if not r.set(f"best-{level}", score, nx=True):
        all_best = int(r.get(f"best-{level}"))
        if score < all_best:
            r.set(f"best-{level}", score)
            all_best = score
    else:
        all_best = score

    if score <= thresholds[level]:
        flag_prefix = ['Lights_are_Linear', 'Search_is_Random', 'Lattice_be_Best']
        return make_response(
            f"你的分值({score})已达到目标分值({thresholds[level]})\n" +
            f"本关中, 你的最佳纪录是 {personal_best}, 全体参赛选手的最佳纪录是 {all_best}\n" +
            f"flag{{{flag_prefix[level]}_{hashlib.sha256(('__lights^Up!lv.'+str(level)+token).encode()).hexdigest()[:16]}}}"
        )
    else:
        return make_response(
            f"你的分值({score})大于目标分值({thresholds[level]}), 不能拿到 Flag\n" +
            f"本关中, 你的最佳纪录是 {personal_best}, 全体参赛选手的最佳纪录是 {all_best}"
        )


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001)
