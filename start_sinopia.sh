#!/bin/bash

# goofys needs to run and mount the storage directory before sinopia runs
# or else sinopia won't detect installed packages
goofys=$(pidof goofys)
until goofys=$(pidof goofys); do
  sleep 1
done

if [ -z $SINOPIA_CONFIG ]; then
  echo "You need to set SINOPIA_CONFIG"
  exit 1
fi

# Get config file
# If you want to pull the config from somewhere else
# Otherwise comment this out the curl command
# curl -s $SINOPIA_CONFIG > /go/config.yaml

echo "Received sinopia config:"
cat $GOPATH/config.yaml

echo "Current user:"
whoami

node $GOPATH/node_modules/sinopia/bin/sinopia --config $GOPATH/config.yaml

