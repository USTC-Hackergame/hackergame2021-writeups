import graphene
from app.models import Note, User
import flask_login
import hashlib
from flask import session


def check_user_access(user_id):
    current_user = flask_login.current_user
    if user_id != current_user.id:
        raise ValueError("This user has no permission to access this.")


class GNote(graphene.ObjectType):
    id = graphene.Int()
    contents = graphene.String()


class GUser(graphene.ObjectType):
    id = graphene.Int()
    username = graphene.String()
    private_email = graphene.String()


class Query(graphene.ObjectType):
    note = graphene.Field(
        GNote, id=graphene.Int(), description="Get a specific note information"
    )
    notes = graphene.List(
        lambda: GNote,
        user_id=graphene.Int(),
        description="Get notes information of a user",
    )
    user = graphene.Field(
        GUser, id=graphene.Int(), description="Get a specific user information"
    )

    def resolve_note(self, info, id):
        note = Note.query.filter_by(id=id).first()
        check_user_access(note.user_id)
        if not note:
            raise ValueError("No such note")
        return GNote(id=note.id, contents=note.contents)

    def resolve_notes(self, info, user_id):
        check_user_access(user_id)
        notes = Note.query.filter_by(user_id=user_id)
        return [GNote(id=note.id, contents=note.contents) for note in notes]

    def resolve_user(self, info, id):
        user = User.query.filter_by(id=id).first()
        if user.username == "admin":
            token = session["token"]
            email = f"flag{{dont_let_graphql_l3ak_data_{hashlib.sha256(('grApH13ak' + token).encode()).hexdigest()[:10]}@hackergame.ustc}}"
        else:
            email = user.email
        return GUser(id=user.id, username=user.username, private_email=email)


schema = graphene.Schema(query=Query)
