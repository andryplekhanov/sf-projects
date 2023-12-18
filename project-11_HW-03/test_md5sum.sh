#!/bin/bash

curl localhost:9889/ --output /tmp/index.html

original_md5sum="$(md5sum index.html | awk -F' ' '{print $1}')"
echo "original_md5sum $original_md5sum"

nginx_md5sum="$(md5sum /tmp/index.html | awk -F' ' '{print $1}')"
echo "nginx_md5sum $nginx_md5sum"

if [ "$original_md5sum" == "$nginx_md5sum" ]
then
    echo "site ok"
else
    echo "Something went wrong"
    exit 1
fi
