#------------------------------------------------------------------------
#                       PROJECT AND APP NAMES
#------------------------------------------------------------------------
PROJ_NAME=$1
APP_NAME=$2

echo "Project name: " $PROJ_NAME
echo "App name: " $APP_NAME

#------------------------------------------------------------------------
#                           CREATE APP
#------------------------------------------------------------------------
python manage.py startapp $APP_NAME

#------------------------------------------------------------------------
#                           APP SETTINGS
#------------------------------------------------------------------------
echo "
INSTALLED_APPS.append('$APP_NAME')" \
>> ./$PROJ_NAME/settings.py

#------------------------------------------------------------------------
#                           PROJECT URLS
#------------------------------------------------------------------------
echo "
from django.urls import include
urlpatterns.append(path('api/social/posts/', include('$APP_NAME.urls')))" \
>> ./$PROJ_NAME/urls.py

#------------------------------------------------------------------------
#                           APP ADMIN
#------------------------------------------------------------------------
echo "
from .models import $APP_NAME

admin.site.register($APP_NAME)" \
>> ./$APP_NAME/admin.py

#------------------------------------------------------------------------
#                           APP MODELS
#------------------------------------------------------------------------
echo "
class $APP_NAME(models.Model):
    content = models.CharField(max_length=120)" \
>> ./$APP_NAME/models.py

#------------------------------------------------------------------------
#                           APP VIEWS
#------------------------------------------------------------------------
echo "
from .models import $APP_NAME
from .serializers import ${APP_NAME}Serializer
from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView
#from .permissions import IsOwnerOrReadOnly

class ListCreatePostView(ListCreateAPIView):
    queryset = $APP_NAME.objects.all()
    serializer_class = ${APP_NAME}Serializer

    def perform_create(self, serializer):
        #serializer.save(buyer=self.request.user)
        serializer.save()

class GetUpdateDeletePostView(RetrieveUpdateDestroyAPIView):
        queryset = $APP_NAME.objects.all()
        serializer_class = ${APP_NAME}Serializer
        lookup_url_kwarg = 'post_id'" \
>> ./$APP_NAME/views.py

#------------------------------------------------------------------------
#                           APP SERIALIZERS
#------------------------------------------------------------------------
echo "
from rest_framework import serializers
from .models import $APP_NAME

class ${APP_NAME}Serializer(serializers.ModelSerializer):
    class Meta:
        model = $APP_NAME
        #exclude = ['name']
        fields = '__all__'" \
> ./$APP_NAME/serializers.py

#------------------------------------------------------------------------
#                           APP URLS
#------------------------------------------------------------------------
echo "
from django.urls import path

from .views import ListCreatePostView, GetUpdateDeletePostView

urlpatterns = [
    path('', ListCreatePostView.as_view()),
    path('<int:post_id>/', GetUpdateDeletePostView.as_view())
]" \
> ./$APP_NAME/urls.py

#------------------------------------------------------------------------
#                           APP MIGRATE DATABASE
#------------------------------------------------------------------------
#python manage.py makemigrations
#python manage.py migrate

#------------------------------------------------------------------------
#                           RUN SERVER
#------------------------------------------------------------------------
#python manage.py runserver


#echo "
#from $APP_NAME.model import $APP_NAME
#$APP_NAME.objects.all()
#$APP_NAME.objects.create(content='new post')
#" > ./$APP_NAME/create_table_entry.py
#
#python create_table_entry.py
#rm create_table_entry.py

#python manage.py runserver