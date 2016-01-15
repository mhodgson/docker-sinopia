#!/bin/bash
# This file should not be needed anymore, leaving for now but don't use it.
# Doesn't work correctly since goofys needs to start before sinopia for packages to be detected
# but for that to happen a syslog daemon needs to be started so goofys can run in the background
# If someone can figure out a way to do that please let me know :)

# Abort if the SINOPIA_BUCKET was not provided
# if [ -z $SINOPIA_BUCKET ]; then
#   echo "You need to set BUCKET environment variable. Aborting!"
#   exit 1
# fi
# 
# # Abort if the AWS_ACCESS_KEY_ID was not provided
# if [ -z $AWS_ACCESS_KEY_ID ]; then
#   echo "You need to set AWS_ACCESS_KEY_ID environment variable. Aborting!"
#   exit 1
# fi
# 
# # Abort if the AWS_SECRET_ACCESS_KEY was not provided
# if [ -z $AWS_SECRET_ACCESS_KEY ]; then
#   echo "You need to set AWS_SECRET_ACCESS_KEY environment variable. Aborting!"
#   exit 1
# fi
# 
# # Set provided AWS credentials for s3fs to use
# if [ ! -z $AWS_ACCESS_KEY_ID ] && [ ! -z $AWS_SECRET_ACCESS_KEY ]; then
#   #set the aws access credentials from environment variables
#   cat > /root/.aws/credentials <<- EOM
# [default]
# aws_access_key_id = $AWS_ACCESS_KEY_ID
# aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
# EOM
# fi
# 
# # start goofys
# $GOPATH/bin/goofys -o allow_other -o nonempty $SINOPIA_BUCKET $GOPATH/bucket/
# 
# if [ -z $SINOPIA_CONFIG ]; then
#   echo "You need to set SINOPIA_CONFIG"
#   exit 1
# fi
# 
# # Get config file
# # If you want to pull the config from somewhere else
# # Otherwise comment this out the curl command
# # curl -s $SINOPIA_CONFIG > /go/config.yaml
# 
# echo "Received sinopia config:"
# cat $GOPATH/config.yaml
# 
# echo "Current user:"
# whoami
# 
# node $GOPATH/node_modules/sinopia/bin/sinopia --config $GOPATH/config.yaml

