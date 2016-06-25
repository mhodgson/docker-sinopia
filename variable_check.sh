#!/bin/bash

# Abort if the SINOPIA_BUCKET was not provided
if [ -z $SINOPIA_STORAGE_BUCKET ]; then
  echo "You need to set SINOPIA_STORAGE_BUCKET environment variable. Aborting!"
  exit 1
fi

if [ -z $SINOPIA_CONFIG_BUCKET ]; then
  echo "You need to set SINOPIA_CONFIG_BUCKET"
  exit 1
fi

# Get config file
aws s3 cp s3://"$SINOPIA_CONFIG_BUCKET"/config.yaml /opt/sinopia/config.yaml

echo "Received sinopia config:"
cat /opt/sinopia/config.yaml
