#!/bin/bash

# Activate Poetry virtual environment

# Check if a virtual environment is already active
if [ -n "$VIRTUAL_ENV" ]; then
    echo "A virtual environment is already active: $VIRTUAL_ENV"
    cd _server/
    python3 manage.py makemigrations
    python3 manage.py migrate
    cd ../client/
    npm run dev &
    cd ../_server/
    python manage.py runserver 2>&1 | grep -v "WARNING: This is a development server"
else
    VENV_PATH=$(poetry env info --path 2>/dev/null)
    if [ -z "$VENV_PATH" ]; then
        echo "Poetry virtual environment not found. Run 'poetry install' first."
        exit 1
    fi
    echo "No virtual environment is active. To activate, run:"
    echo "source $VENV_PATH/bin/activate"
fi