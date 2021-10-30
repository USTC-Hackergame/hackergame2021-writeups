from django.http.response import HttpResponse
from django.shortcuts import redirect, render
from .forms import LoginForm
from .models import User, Content
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.views.decorators.http import require_http_methods
from django.shortcuts import get_object_or_404

import hashlib


def getflagObj(request, content):
    token = request.session['token']
    text = f"flag{{u5e_crypt0graph1ca1ly_secure_PRNG_plz_{hashlib.sha256(('entr0py' + token).encode()).hexdigest()[:10]}}}"
    content.contents = text
    return content


def index(request):
    return render(
        request,
        "index.html",
        {"contents": Content.objects.filter(public=True).order_by("-date")},
    )


def register(request):
    if request.method == "GET":
        return render(request, "register.html")
    elif request.method == "POST":
        return HttpResponse("站点注册功能暂时关闭。")


def login_view(request):
    if request.method == "POST":
        form = LoginForm(request.POST)
        if form.is_valid():
            user = authenticate(
                username=form.cleaned_data["username"],
                password=form.cleaned_data["password"],
            )
            if user is not None:
                login(request, user)
                next = request.GET.get("next")
                if next:
                    return redirect(next)
                else:
                    return redirect("dashboard")
            else:
                messages.error(request, "用户名或密码错误！")
    return render(request, "login.html")


@login_required
def dashboard(request):
    return render(
        request,
        "dashboard.html",
        {
            "contents": [
                i if i.contents != 'flag' else getflagObj(request, i) for i in Content.objects.filter(user=request.user).order_by("-date")
            ]
        },
    )


@require_http_methods(["POST"])
def logout_view(request):
    logout(request)
    return redirect("/")


def profile(request, id):
    return render(request, "profile.html", {"profile_user": get_object_or_404(User, id=id)})
