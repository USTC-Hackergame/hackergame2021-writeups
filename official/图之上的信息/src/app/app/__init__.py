from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from app.secret import secret_key
from flask_login import LoginManager

app = Flask(__name__)
app.secret_key = secret_key
app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///./db.sqlite3"
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
db = SQLAlchemy(app)

login_manager = LoginManager()
login_manager.init_app(app)

from app.commands import register_commands

register_commands(app)

from app.models import *
from app.views import *


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(user_id)
