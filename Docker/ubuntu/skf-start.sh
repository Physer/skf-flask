#!/bin/bash

# Get the correct origin for the API
APIENDPOINT=$ORIGIN
if [ -z "$APIENDPOINT" ]
then
    echo "No API endpoint found, please enter one with the ORIGIN environment flag"
    exit
fi

echo "Selected origin for the API endpoint: ${APIENDPOINT}"

# Build the front-end
cd /skf/angular
perl -pi -e "s/http:\/\/127.0.0.1:8888\/api/http:\/\/${APIENDPOINT}\/api/" /skf/angular/src/environments/environment.ts
npm run build
cd ..
cd ..

# Start the NGINX server
nginx

# Start the SKF Python API
export FLASK_APP=skf/app.py
export PYTHONPATH=./
export FLASK_DEBUG=0
python3.7 /skf/app.py