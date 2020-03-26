from django.db import models
from social.models import Post
from django.contrib.postgres.fields import JSONField

# Create your models here.

from django.contrib.auth.models import AbstractUser
from django.conf import settings

class User(AbstractUser):
    # Field used for authentication
    USERNAME_FIELD = 'email'

    # Additional fields required when using createsuperuser (USERNAME_FIELD and passwords are always required)
    REQUIRED_FIELDS = ['username']

    email = models.EmailField(unique=True)

    following = models.ManyToManyField(to=settings.AUTH_USER_MODEL, related_name='followers', blank=True)

    friends = models.ManyToManyField(to=settings.AUTH_USER_MODEL, related_name='friendship', blank=True)
    sent_friend_request = models.ManyToManyField(to=settings.AUTH_USER_MODEL, related_name='received_friend_request', blank=True)

    liked_posts = models.ManyToManyField(
        verbose_name='liked posts',
        to=Post,
        related_name='liked_by',
        blank=True,
    )
    
    avatar = models.CharField(max_length=200,default=None,blank=True,null=True)

    about_me = models.TextField(default=None,blank=True,null=True)

    #things_user_likes = JSONField(default=[])
    things_user_likes = models.TextField(default=None,blank=True,null=True)

    def __str__(self):
        return f'User {self.id}: {self.email}'
