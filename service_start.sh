#!/bin/bash

supervisorctl start variable_check

while supervisorctl status variable_check | grep -i -q RUNNING; do
  echo "Waiting for check to complete..."
  sleep 1
done

supervisorctl start sync_local_with_s3

while supervisorctl status sync_local_with_s3 | grep -i -q RUNNING; do
  echo "Waiting for sync to complete..."
  sleep 5
done

supervisorctl start sinopia

crontab -l > mycron
# if 10 minutes is too expensive change to longer time
echo "10 * * * * supervisorctl start sync_s3_with_local > /var/log/cron.log  && echo 'done with sync'" >> mycron
crontab mycron
rm mycron
