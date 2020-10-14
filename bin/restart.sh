#!/bin/bash

docker-compose stop
docker-compose up --build -d -f ../docker-compose.yml