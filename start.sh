#!/bin/bash

# Abort if the SINOPIA_BUCKET was not provided
if [ -z $SINOPIA_BUCKET ]; then
  echo "You need to set BUCKET environment variable. Aborting!"
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
  echo $AWS_ACCESS_KEY_ID:$AWS_SECRET_ACCESS_KEY > ~/.passwd-s3fs
  chmod 600 ~/.passwd-s3fs
fi

# start s3 fuse
/usr/local/bin/s3fs $SINOPIA_BUCKET /opt/sinopia/bucket/ -o allow_other -o nonempty -o mp_umask="0022" #-d -d -f -o f2 -o curldbg


if [ -z $SINOPIA_CONFIG ]; then
  echo "You need to set SINOPIA_CONFIG"
  exit 1
fi

# Get config file
# If you want to pull the config from somewhere else
# Otherwise comment this out the curl command
mkdir -p /opt/sinopia
curl -s $SINOPIA_CONFIG > /opt/sinopia/config.yaml

echo "Received sinopia config:"
cat /opt/sinopia/config.yaml

echo "Current user:"
whoami

echo "Base directory:"
ls -lrt /opt/sinopia/bucket/storage

echo "Write to storage:"
touch /opt/sinopia/bucket/storage/test

# Set file and folder permissions correctly
# Only needed if you upload files/folders directly into S3 bucket
# Otherwise permissions are set correctly
# Only need to run these if not using an empty S3 bucket
# find /opt/sinopia/bucket/storage -type d -exec chmod 755 {} \;
# find /opt/sinopia/bucket/storage -type f -exec chmod 644 {} \;

node /opt/sinopia/node_modules/sinopia/bin/sinopia --config /opt/sinopia/config.yaml
