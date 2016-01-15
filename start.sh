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
  cat > /root/.aws/credentials <<- EOM
[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
EOM
fi

# goofys needs a syslog daemon running in order to run in the background
syslog=$(pidof syslog-ng)
until syslog=$(pidof syslog-ng); do
  echo "Waiting for syslog-ng..."
  sleep 1
done

echo "Done waiting...starting goofys"
# start goofys
$GOPATH/bin/goofys -o allow_other -o nonempty $SINOPIA_BUCKET $GOPATH/bucket/

# Goofys logs to syslog a message when it succesfully mounts
# wait for this before starting sinopia
count=0
while ! grep -q "successfully mounted" /var/log/syslog; do
  if [ $count -eq 30 ]; then
    echo "Goofys never mounted successfully. Something went wrong..."
    exit 2
  fi
  echo "Waiting for goofys..."
  ((count=count+1))
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

