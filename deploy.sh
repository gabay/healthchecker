#!/bin/sh

docker build -t gabay/healthchecker .
docker push gabay/healthchecker
