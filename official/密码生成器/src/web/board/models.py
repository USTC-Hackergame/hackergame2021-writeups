from django.db import models
from django.contrib.auth.models import AbstractUser


class User(AbstractUser):
    def save(self, *args, **kwargs):
        if "update_fields" in kwargs and "last_login" in kwargs["update_fields"]:
            kwargs["update_fields"].remove("last_login")
            if not kwargs["update_fields"]:
                return
        super(User, self).save(*args, **kwargs)


class Content(models.Model):
    contents = models.TextField()
    date = models.DateTimeField()
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    public = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.user} 于 {self.date} 发布的{'公开' if self.public else '私密'}信息"
