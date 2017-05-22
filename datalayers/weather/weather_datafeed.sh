#!/bin/bash

set -e;

if [ "$1" == "" ]
then
  echo "You must specify a database name to create and populate."
  exit 1
fi

if [ "$2" == "" ]
then
  echo "You must specify a database user to create the schema with."
  exit 1
fi
psql -f weather_datafeed.sql "$1" "$2"
