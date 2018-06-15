---
title: Useful but rarely used bash commands
description: List of useful bash commands that I only need occasionally
header: Useful but rarely used bash commands
---


This is a list of bash commands I've found really useful but have only needed rarely so I'm recording these here for future reference.

&nbsp;

Search and replace over multiple files

> find . -type f -exec sed -i 's/old/new/g' {} \;

Tidy / format XML file

> tidy -xml -i -o modified.xml original.xml

PHP Lint test / syntax check

> find . -name \*.php -exec php -l "{}" \;

Fix line endings

>  find -type f -name \*.php -exec dos2unix {} \;

Recursively chmod only PHP files

> find . -type f -name '\*.php' -exec chmod 644 {} \;

Recursively chmod only directories

> find . -type d -exec chmod 755 {} \;

Curl REST requests

> curl -X DELETE http://localhost:3000/users/3

> curl -d "user[first_name]=john&user['last_name']=smith" http://localhost:3000/users

&nbsp;
