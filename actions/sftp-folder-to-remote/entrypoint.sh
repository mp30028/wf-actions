#!/bin/bash

set -eu
# -e -->  exit on error
# -u -->  all variables must be set before use instead of being ignored

username=$1
host=$2
port=$3
ssh_private_key=$4
local_path=$5
remote_path=$6

#echo $username
#echo $host
#echo $port
#echo $ssh_private_key
#echo $local_path
#echo $remote_path

SSH_PRIVATE_KEY_FILE=./id_rsa
SFTP_BATCH_FILE=./sftp_batch

printf "%s" "$ssh_private_key" > $SSH_PRIVATE_KEY_FILE
chmod 600 $SSH_PRIVATE_KEY_FILE

echo 'Starting SFTP...'
printf "%s" "put -r $local_path $remote_path" > $SFTP_BATCH_FILE

ssh -o StrictHostKeyChecking=no -p $port -i $SSH_PRIVATE_KEY_FILE $username@$host mkdir -p $remote_path

sftp -b $SFTP_BATCH_FILE -P $port -o StrictHostKeyChecking=no -i $SSH_PRIVATE_KEY_FILE $username@$host

rm $SSH_PRIVATE_KEY_FILE
rm $SFTP_BATCH_FILE

echo 'Transfer completed successfully!'
exit 0