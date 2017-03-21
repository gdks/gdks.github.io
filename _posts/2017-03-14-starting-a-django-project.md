---
title: Starting a Django Project and App
description:
header: Starting a Django Project and App
---

### Create project environment

Python's venv module allows creation of lightweight virtual environments. These are isolated working copies of Python which
allow you to work on a specific project without worry of affecting other projects. Each virtual environment has its own Python binary, allowing creation of environments with various Python versions, and can have its own independent set of installed Python packages.

We start by creating a venv using the following command.

> python3 -m venv [environment-name]

### Activate virtual environment

We can now change to the directory created by running the venv command and activate the virtual environment. Any python commands run after this will be run using the python binary islolated within the virtual environment.

> cd [environment-name] && . bin/activate

### Starting a django project

We can now use pip to install the Django framework. This pip install will be isolated within our virtual environment.

> pip install django

We start a new Django project and change to within the project diretory.

> django-admin.py startproject [projectname] && cd [projectname]

### Start an app

We can now generate a new Django app within our project and add that to the installed apps within the project settings.

> python manage.py startapp [app-name]

> Add app to settings.py INSTALLED_APPS

### Run the web server

If we now run the server we should see the default Django web page.

> python manage.py runserver

&nbsp;
