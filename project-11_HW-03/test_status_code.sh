#!/bin/bash

wget_result="$(wget -NS localhost:9889/ 2>&1|grep "HTTP/"|awk '{print $2}')"
echo "status_code $wget_result"

if [ "$wget_result" == 304 ] || [ "$wget_result" == 200 ]
then
    echo "site ok"
else
    echo "Something went wrong"
    exit 1
fi
