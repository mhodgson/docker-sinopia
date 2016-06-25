#!/bin/bash

/opt/sinopia/variable_check.sh >> /var/log/variable_check.log

aws s3 sync s3://"$SINOPIA_STORAGE_BUCKET"/ /opt/sinopia/storage/ >> /var/log/sync_local_on_startup.log

crontab -l 2>&1  > mycron
echo "*/10 * * * * $(which aws) s3 sync /opt/sinopia/storage/ s3://$SINOPIA_STORAGE_BUCKET/ >> /var/log/cron.log" >> mycron
crontab mycron
rm mycron
