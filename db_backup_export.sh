#!/bin/bash

cd ~

#run autobackup script to create .sql.gz file
sudo automysqlbackup
#WORKING

# copy that file to ./
sudo find /var/lib/automysqlbackup/daily/nokkowiki_db/ -name '*.gz' -exec cp "{}" ./ \;
#WORKING

# clear out the existing backup folder to save storage cost on server
sudo find /var/lib/automysqlbackup/daily/nokkowiki_db/ -type f -delete
#WORKING

# send backup file to S3 bucket
sudo aws s3 cp ./nokkowiki_db_* s3://nokkowiki-mysqlbackup-028665065233-20201016
#WORKING

# delete the sql backup file in ./
sudo rm nokkowiki_db*
#WORKING


# this will be configured in a cron job to run at 6am JST everyday 
# that's 21:00 UTC