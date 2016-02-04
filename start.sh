#!/bin/bash

# Abort if the SINOPIA_BUCKET was not provided
if [ -z $SINOPIA_BUCKET ]; then
  echo "You need to set SINOPIA_BUCKET environment variable. Aborting!"
  exit 1
fi

# Abort if the AWS_ACCESS_KEY_ID was not provided
if [ -z $AWS_ACCESS_KEY_ID ]; then
  echo "You need to set AWS_ACCESS_KEY_ID environment variable. Aborting!"
  exit 1
fi

# Abort if the AWS_SECRET_ACCESS_KEY was not provided
if [ -z $AWS_SECRET_ACCESS_KEY ]; then
  echo "You need to set AWS_SECRET_ACCESS_KEY environment variable. Aborting!"
  exit 1
fi

# Set provided AWS credentials for s3fs to use
if [ ! -z $AWS_ACCESS_KEY_ID ] && [ ! -z $AWS_SECRET_ACCESS_KEY ]; then
  #set the aws access credentials from environment variables
  mkdir -p /root/.aws/
  cat > /root/.aws/credentials <<- EOM
[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
EOM
fi

if [ -z $SINOPIA_CONFIG ]; then
  echo "You need to set SINOPIA_CONFIG"
  exit 1
fi

# Get config file
# If you want to pull the config from somewhere else
# Otherwise comment this out the curl command
curl -s $SINOPIA_CONFIG > /home/config.yaml

# echo "Received sinopia config:"
cat /home/config.yaml

