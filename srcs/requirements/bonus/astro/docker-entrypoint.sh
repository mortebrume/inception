#!/bin/sh

set -e

if [ ! -e "/var/www/html/index.html" ]; then
    npm i
    npm run build
    RESULT=$?
    if [ $RESULT -eq 0 ] && [ -d "./dist" ]; then
        echo "[i] Build successfull"
        cp -r dist/* /var/www/html/
    else
        echo "[!] Build failed !"
    fi
fi