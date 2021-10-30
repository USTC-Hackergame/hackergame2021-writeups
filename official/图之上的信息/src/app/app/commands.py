from flask.cli import with_appcontext
from app.models import User, Note

# from app.secret import flag
from app import db
import click


@click.command()
@with_appcontext
def seed():
    db.create_all()
    user1 = User(
        username="admin",
        password="99hve1ANsfCOUtwL1bl8mOYzQveTTpelKViowyb0gieiXXabR1qoZmWw5Gl9GBV_bcV4fEhjNSGZPdbmWx4DFw",
        email="placeholder@example.com",
    )
    user2 = User(username="guest", password="guest", email="guest@example.com")
    objs = [user1, user2]
    for obj in objs:
        db.session.add(obj)
    db.session.commit()

    note1 = Note(contents="Hello, world!", user_id=user1.id)
    note2 = Note(contents="Flag 是 admin 的邮箱。", user_id=user2.id)
    # note3 = Note(
    #     contents="For example, if admin's email is admin@example.com, the flag is flag{admin@example.com}",
    #     user_id=user2.id,
    # )
    # objs = [note1, note2, note3]
    objs = [note1, note2]
    for obj in objs:
        db.session.add(obj)
    db.session.commit()


@click.command()
@with_appcontext
def reset():
    User.query.delete()
    Note.query.delete()
    db.session.commit()


def register_commands(app):
    app.cli.add_command(seed)
    app.cli.add_command(reset)
