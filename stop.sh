#!/bin/bash

docker kill `docker ps|awk '{if ($1 != "CONTAINER"){print $1}}'`
