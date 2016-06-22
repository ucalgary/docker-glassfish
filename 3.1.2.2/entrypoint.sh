#!/bin/sh

if [ "$1" = 'asadmin' ]; then
	exec "$@"
fi

exec "$@"
