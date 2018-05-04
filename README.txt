Django docker investigation
https://semaphoreci.com/community/tutorials/dockerizing-a-python-django-web-application

---------------------------------------
Install django globally

$ sudo pip install django

or using the requirements file with specific requirements (still global):

$ sudo pip install -r requirements.txt

---------------------------------------
Create Django Project

$ django-admin startproject helloworld

directory structure for project 

├── helloworld
│   ├── db.sqlite3
│   ├── helloworld
│   │   ├── __init__.py
│   │   ├── __init__.pyc
│   │   ├── settings.py
│   │   ├── settings.pyc
│   │   ├── urls.py
│   │   ├── urls.pyc
│   │   ├── views.py
│   │   ├── views.pyc
│   │   ├── wsgi.py
│   │   └── wsgi.pyc
│   └── manage.py
└── requirements.txt

---------------------------------------
Added views.py

from django.http import HttpResponse

def index(request):
    return HttpResponse("Django says... Hello, world!”)

---------------------------------------
Edit urls.py —> How To import a .py module

URLs entry
https://docs.djangoproject.com/en/1.11/topics/http/urls/

from django.conf.urls import url
from django.contrib import admin
from . import views # add local .py file
urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'', views.index),

---------------------------------------
Run the django from python first outside of Docker

$ python manage.py runserver

sengi:django-docker $ cd helloworld/
sengi:helloworld $ python manage.py runserver
Performing system checks...

System check identified no issues (0 silenced).
April 30, 2018 - 01:10:27
Django version 1.11.12, using settings 'helloworld.settings'
Starting development server at http://127.0.0.1:8000/
Quit the server with CONTROL-C.

---------------------------------------
Create start.sh script to run Django within Gunicorn

#!/bin/bash

# Start Gunicorn processes
echo Starting Gunicorn.
exec gunicorn helloworld.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 3

---------------------------------------
Dockerfile
FROM python:2.7
RUN mkdir -p /app 
WORKDIR /app 
COPY . /app/ 
RUN pip install --no-cache-dir -r requirements.txt 
EXPOSE 8000
RUN ["chmod", "+x", "/app/start.sh"]
CMD ["/app/start.sh”]

---------------------------------------
Build Image
667  docker build -t django.local .

---------------------------------------
Run Container
629  docker run -it -p 8000:8000 django.local



