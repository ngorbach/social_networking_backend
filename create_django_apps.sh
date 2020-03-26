#------------------------------------------------------------------------
#                  CONSTANTS: PROJECT AND APP NAMES
#------------------------------------------------------------------------
PROJ_NAME=motion
APP_NAME1=User
APP_NAME2=Post

#------------------------------------------------------------------------
#                           CREATE PROJECT
#------------------------------------------------------------------------
./create_django_motion_project_with_jwt_token.sh $PROJ_NAME

#------------------------------------------------------------------------
#                           CREATE APPS
#------------------------------------------------------------------------
./create_django_user_app.sh $PROJ_NAME $APP_NAME1
./create_django_post_app.sh $PROJ_NAME $APP_NAME2

#------------------------------------------------------------------------
#                           RUN SERVER
#------------------------------------------------------------------------
rm db.sqlite3
python manage.py makemigrations
python manage.py migrate

python manage.py runserver