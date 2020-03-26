#!/bin/bash
python manage.py makemigrations
python manage.py migrate
#python manage.py collectstatic --no-input
python manage.py collectstatic
gunicorn -w 4 -b 0.0.0.0:8000 Motion.wsgi:application