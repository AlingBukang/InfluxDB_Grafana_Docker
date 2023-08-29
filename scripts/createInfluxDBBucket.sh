#!/bin/sh

set -e
influx bucket create -n telegraf -o ${DOCKER_INFLUXDB_INIT_ORG} -r 1w