#!/bin/sh

set -e

envsubst '$APP_PORT,$ROOT_PATH,$SERVER_NAME,$SSL_CERTIFICATE_PATH,$SSL_CERTIFICATE_KEY_PATH' < /etc/nginx/conf.d/templates/default.conf > /etc/nginx/conf.d/default.conf

exec "$@"
