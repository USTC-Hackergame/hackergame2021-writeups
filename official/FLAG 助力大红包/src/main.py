from flask import Flask, request, session, render_template, abort
from datetime import timedelta
import time
import uuid
import os
import sys
import redis
import hashlib
import re

from werkzeug.utils import redirect

app = Flask(__name__)
app.config['SECRET_KEY'] = os.urandom(24)
app.config['PERMANENT_SESSION_LIFETIME'] = timedelta(days=1)

total_count = 256
start_money = 0.5
total_money = 1
total_time = 600

domain_name = os.getenv("domain", default="") # outside http://ip:port 202.38.93.111:8899
redis_host = os.getenv("redis_host", "localhost")
debug_mode = os.getenv("debug", False)
db = redis.StrictRedis(host=redis_host, port=6379)


def get_real_ip(request: request):
    '''Get client's real ip address using `remote_addr` or `X-Forwarded-For`'''

    ips = request.headers.get("X-Forwarded-For") or request.environ.get("X-Forwarded-For")
    if ips is not None:
        ip = ips.split(",")[0]
    else:
        ip = request.headers.get("X-Real-IP") or request.environ.get("X-Real-IP")
    if ip is None:
        ip = request.remote_addr
    return ip

def check_ip(ip: str):
    return re.match(r"^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", ip)

def get_money(count: int):
    ret = (- 0.0000076 * (count - total_count) ** 2 + 1)
    if count >= total_count or ret >= total_money:
        return total_money
    return ret


@app.route('/api/login', methods=["POST"])
def login():
    token = request.form.get("token")
    internal_login(token)
    # if token is not None and token != "":
    #     session['token'] = token

    #     helplink = str(uuid.uuid4())
    #     db.set("link:"+token, helplink)
    #     db.set("token:"+helplink, token)
    #     db.set("time:"+token, time.time())
    #     db.delete("from:"+token)
    return redirect("/")

def internal_login(token: str) -> None:
    if token is not None and token != "":
        print("login with token:", token)
        session['token'] = token

        helplink = str(uuid.uuid4())
        db.set("link:"+token, helplink)
        db.set("token:"+helplink, token)
        db.set("time:"+token, time.time())
        db.delete("from:"+token)

@app.route('/invite/<string:helplink>', methods=["GET","POST"])
def invite(helplink):
    token = db.get("token:"+helplink)
    if token is None:
        return render_template("invite.html", fail_msg="失败！无效的助力链接！")
    token = token.decode("utf-8")
    check_link = db.get("link:"+token)
    if check_link is None or check_link.decode("utf-8") != helplink:
        return render_template("invite.html", fail_msg="失败！无效的助力链接！")

    if request.method == "GET":
        return render_template("invite.html")
    else:

        if db.exists("try:"+token):
            t = db.incr("try:"+token)
            db.expire("try:"+token, 1)
            if t > 10:
                return render_template("invite.html", fail_msg="失败！操作速度太快了，请稍后再试！")
        else:
            db.set("try:"+token, 0)
            db.expire("try:"+token, 1)


        start_time = db.get("time:"+token)
        try:
            start_time = float(start_time.decode("utf-8"))
        except:
            return render_template("invite.html", fail_msg="失败！无效的助力链接！")

        current_time = time.time()
        if current_time - start_time > total_time:
            # timeout
            return render_template("invite.html", fail_msg="失败！超时，该助力链接已经失效！")

        cip = request.form.get("ip")
        sip = get_real_ip(request)
        if debug_mode:
            print("cip:",cip,"sip:", sip)
        if cip is None or not check_ip(cip):
            # error IPv4 format
            return render_template("invite.html", fail_msg=f"失败！错误的前端检测 IPv4 地址格式： {cip} ！")
        if not check_ip(sip):
            # error IPv4 format
            return render_template("invite.html", fail_msg=f"失败！错误的后端检测 IPv4 地址格式： {sip} ！")
        if cip != sip:
            return render_template("invite.html", fail_msg=f"失败！检测到前后端检测 IPv4 地址不匹配，前端地址： {cip} ，后端地址： {sip} 。疑似地址伪造！")

        try:
            first_part = cip.split(".")[0]
            if db.sismember("from:"+token, first_part):
                return render_template("invite.html", fail_msg=f"失败！重复的 /8 地址： {cip} 。请邀请全球其他好友参与助力，共同打造世界一流大砍刀！")
            else:
                db.sadd("from:"+token, first_part)
                return render_template("invite.html", succ_msg=f"助力成功！您的 IPv4 地址是： {cip} ，成功共同打造世界一流大砍刀！")
        except:
            return render_template("invite.html", fail_msg=f"失败！错误的IPv4地址：{cip} ！")


@app.route('/')
def index():
    url_token =  request.args.get("token")
    if url_token is not None and url_token != "":
        internal_login(url_token)
        return redirect("/")

    token = session.get("token")
    is_login = token is not None and token != ""
    if is_login:
        help_count = db.scard("from:"+token)
        current_money = get_money(help_count)

        helplink = db.get("link:" + token)
        try:
            helplink = domain_name + "/invite/"+ helplink.decode("utf-8")
        except:
            return logout("邀请链接错误，请重新登录！", token)

        start_time = db.get("time:" + token)
        try:
            start_time = int(float(start_time.decode("utf-8")))
        except:
            return login("参与活动时间错误，请重新登录！",token)
        return render_template("index.html", is_login=is_login, current_money=current_money, helplink=helplink, start_time=start_time, total_money=total_money, total_time=total_time, help_count= help_count)

    return render_template("index.html", is_login=is_login, total_money=total_money)


@app.route('/help')
def help():
    return render_template("help.html")

@app.route('/checkout')
def checkout():
    token = session.get("token")
    if token is None:
        return redirect("/")
    if db.scard("from:"+token) >= total_count:
        return flag(token)
    return f"没有达到 {total_money} 个 flag，无法提现！"

@app.route("/logout")
def exit():
    token = session.get("token")
    if token is None:
        return redirect("/")
    else:
        return logout("退出成功，欢迎下次参与！",token)

def flag(token = None):
    msg = 'giv3_m3'+token
    return f"flag{{r3d-enve10p3-{hashlib.sha256(msg.encode('utf-8')).hexdigest()[:10]}}}"

def logout(msg: str, token = None):
    fail_msg = msg
    session.clear()
    if token is not None:
        db.delete("from:"+token)
        db.delete("link:"+token)
        db.delete("time:"+token)
    return render_template("index.html", fail_msg = fail_msg, is_login = False, total_money=total_money)

if __name__ == '__main__':
    app.run(debug=debug_mode, port=8899)
