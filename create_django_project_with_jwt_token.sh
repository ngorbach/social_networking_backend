#------------------------------------------------------------------------
#                        PROJECT NAME
#------------------------------------------------------------------------
PROJ_NAME=$1
echo "Project Name: $PROJ_NAME"

#------------------------------------------------------------------------
#                       CREATE DJANGO PROJECT
#------------------------------------------------------------------------
django-admin startproject $PROJ_NAME .

#------------------------------------------------------------------------
#                       CREATE DATABASE
#------------------------------------------------------------------------
python manage.py makemigrations
python manage.py migrate
python manage.py createsuperuser --username=nico --email=nico@gmail.com

#------------------------------------------------------------------------
#                    CREATE JWT TOKEN - URLS
#------------------------------------------------------------------------
echo "
from rest_framework_simplejwt import views as jwt_views

urlpatterns.append(path('api/token/', jwt_views.TokenObtainPairView.as_view())),
urlpatterns.append(path('api/token/refresh/', jwt_views.TokenRefreshView.as_view())),
urlpatterns.append(path('api/token/verify/', jwt_views.TokenVerifyView.as_view()))" \
>> ./$PROJ_NAME/urls.py

#------------------------------------------------------------------------
#                    CREATE JWT TOKEN - SETTINGS
#------------------------------------------------------------------------
echo "
REST_FRAMEWORK = {
'DEFAULT_AUTHENTICATION_CLASSES': [
'rest_framework_simplejwt.authentication.JWTAuthentication',
],
}" >> ./$PROJ_NAME/settings.py

#------------------------------------------------------------------------
#        CREATE JWT TOKEN - SETTINGS (SET TOKEN EXPIRY PERIOD)
#------------------------------------------------------------------------
echo "
from datetime import timedelta
SIMPLE_JWT = {
    'ACCESS_TOKEN_LIFETIME': timedelta(days=5),
    'REFRESH_TOKEN_LIFETIME': timedelta(days=5)
}" >> ./$PROJ_NAME/settings.py




# run the server
#open -a "Google Chrome" http://127.0.0.1:8000/admin/
#python manage.py runserver


#python manage.py runserver &
