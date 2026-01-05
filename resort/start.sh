#!/usr/bin/env bash

# Create superuser only if NOT already created
echo "from django.contrib.auth import get_user_model;
User=get_user_model();
import os;
username=os.getenv('DJANGO_SUPERUSER_USERNAME');
password=os.getenv('DJANGO_SUPERUSER_PASSWORD');
print('Checking for existing superuser...');
if username and password and not User.objects.filter(username=username).exists():
    User.objects.create_superuser(username=username, password=password);
    print('Superuser created.');
else:
    print('Superuser already exists or env vars missing.');
" | python manage.py shell

gunicorn resort.wsgi:application --bind 0.0.0.0:8000