#!/bin/bash
python manage.py makemigrations
python manage.py migrate
#python manage.py collectstatic --no-input
python manage.py collectstatic
rm -rf /frontend/build/* && cp -r /frontend_tmp/* /frontend
gunicorn -w 4 -b 0.0.0.0:8000 Motion.wsgi:application