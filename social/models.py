from django.db import models
#from django.contrib.auth import get_user_model
from django.conf import settings

#User = get_user_model()

# Create your models here.

class Post(models.Model):
    user = models.ForeignKey(to=settings.AUTH_USER_MODEL, related_name='posts', on_delete=models.CASCADE)
    title = models.CharField(max_length=120)
    content = models.CharField(max_length=120)
    created = models.DateTimeField(auto_now_add=True)
