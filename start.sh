#!/bin/bash

# Start Gunicorn processes
echo Starting Gunicorn.
exec gunicorn helloworld.wsgi:application \
    --bind 0.0.0.0:8000 \
    --chdir helloworld \
    --log-level info \
    --workers 2
