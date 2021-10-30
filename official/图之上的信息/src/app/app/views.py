from app.schema import schema
from app import app
from graphql_server.flask import GraphQLView
from flask.templating import render_template
from flask import request, flash, redirect
from flask_login import login_user, logout_user, login_required
from app.models import User


app.add_url_rule(
    "/graphql",
    view_func=GraphQLView.as_view(
        "graphql",
        schema=schema.graphql_schema,
        graphiql=False,
    ),
)

@app.route("/graphiql", methods=["GET"])
def no_graphiql():
    return "出于安全性考虑，GraphiQL 已关闭。"


@app.route("/notes", methods=["GET"])
@login_required
def notes():
    return render_template("notes.html")


@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]
        user = User.query.filter_by(username=username, password=password).first()
        if user is None:
            flash("用户名或密码错误")
        else:
            login_user(user)
            flash("登录成功")
            return redirect("/notes")
    return render_template("index.html")


@app.route("/logout", methods=["POST"])
def logout():
    logout_user()
    return redirect("/")
