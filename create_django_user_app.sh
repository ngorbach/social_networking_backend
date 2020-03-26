#------------------------------------------------------------------------
#                        PROJECT AND APP NAMES
#------------------------------------------------------------------------
PROJ_NAME=$1
APP_NAME=$2

#------------------------------------------------------------------------
#                           CREATE APP
#------------------------------------------------------------------------
python manage.py startapp $APP_NAME

#------------------------------------------------------------------------
#                           APP SETTINGS
#------------------------------------------------------------------------
echo "
INSTALLED_APPS.append('$APP_NAME')" >> ./$PROJ_NAME/settings.py

echo "
# users should be the name of your app, User should be the name of your model
AUTH_USER_MODEL = '$APP_NAME.User'" >> ./$PROJ_NAME/settings.py

#------------------------------------------------------------------------
#                          PROJECT URLS
#------------------------------------------------------------------------
echo "
from django.urls import include
urlpatterns.append(path('api/users/', include('$APP_NAME.urls')))" >> ./$PROJ_NAME/urls.py

#------------------------------------------------------------------------
#                           APP ADMIN
#------------------------------------------------------------------------
echo "
from django.contrib import admin
from .models import User
from django.contrib.auth.admin import UserAdmin

@admin.register(User)
class UserAdmin(UserAdmin):
    readonly_fields = ('date_joined',)
    # fields shown when creating a new instance
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('email', 'username', 'password1', 'password2')}
         ),
    )
    # fields when reading / updating an instance
    fieldsets = (
        (None, {'fields': ('email', 'username', 'password')}),
        ('Personal info', {'fields': ('first_name', 'last_name')}),
        ('Permissions', {'fields': ('is_active', 'is_staff', 'is_superuser', 'user_permissions')}),
        ('Important dates', {'fields': ('last_login', 'date_joined')}),
        ('Groups', {'fields': ('groups',)}),
    )
    # fields which are shown when looking at an list of instances
    list_display = ('email', 'username', 'first_name', 'last_name', 'is_staff')
    ordering = ('email',)" > ./$APP_NAME/admin.py

#------------------------------------------------------------------------
#                           APP MODELS
#------------------------------------------------------------------------
echo "
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    # Field used for authentication
    USERNAME_FIELD = 'email'

    # Additional fields required when using createsuperuser (USERNAME_FIELD and passwords are always required)
    REQUIRED_FIELDS = ['username']

    email = models.EmailField(unique=True)

    def __str__(self):
        return f'User {self.id}: {self.email}'" >> ./$APP_NAME/models.py

#------------------------------------------------------------------------
#                           APP VIEWS
#------------------------------------------------------------------------
echo "
from .serializers import ${APP_NAME}Serializer
from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView
from rest_framework.permissions import IsAdminUser

from django.contrib.auth import get_user_model
$APP_NAME = get_user_model()

class ListCreatePostView(ListCreateAPIView):
    queryset = $APP_NAME.objects.all()
    serializer_class = ${APP_NAME}Serializer
    #permission_classes = [IsAdminUser]

    def perform_create(self, serializer):
        #serializer.save(buyer=self.request.user)
        serializer.save()

class GetUpdateDeletePostView(RetrieveUpdateDestroyAPIView):
        queryset = $APP_NAME.objects.all()
        serializer_class = ${APP_NAME}Serializer
        lookup_url_kwarg = 'user_id'" >> ./$APP_NAME/views.py

#------------------------------------------------------------------------
#                           APP SERIALIZERS
#------------------------------------------------------------------------
echo "
from django.contrib.auth import get_user_model
from rest_framework import serializers

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        exclude = ['password']" > ./$APP_NAME/serializers.py

#------------------------------------------------------------------------
#                           APP URLS
#------------------------------------------------------------------------
echo "
from django.urls import path

from .views import ListCreatePostView, GetUpdateDeletePostView

urlpatterns = [
    path('', ListCreatePostView.as_view()),
    path('<int:post_id>/', GetUpdateDeletePostView.as_view())
]" > ./$APP_NAME/urls.py

#------------------------------------------------------------------------
#                           APP MIGRATE DATABASE
#------------------------------------------------------------------------
#python manage.py makemigrations
#python manage.py migrate



#echo "
#from $APP_NAME.model import $APP_NAME
#$APP_NAME.objects.all()
#$APP_NAME.objects.create(content='new post')
#" > ./$APP_NAME/create_table_entry.py
#
#python create_table_entry.py
#rm create_table_entry.py

#python manage.py runserver