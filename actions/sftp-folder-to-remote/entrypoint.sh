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
args=$7
remote_path_subdir="/staging"

SSH_PRIVATE_KEY_FILE='./id_rsa'
SFTP_BATCH_FILE='./sftp'

printf "%s" "$ssh_private_key" > $SSH_PRIVATE_KEY_FILE
sudo chmod 400 $SSH_PRIVATE_KEY_FILE

echo 'Starting SFTP...'
printf "%s" "put -r $local_path $remote_path$remote_path_subdir" > $SFTP_BATCH_FILE

sudo ssh -o StrictHostKeyChecking=no -p $port -i $SSH_PRIVATE_KEY_FILE $username@$host mkdir -p $remote_path$remote_path_subdir

sudo sftp -b $SFTP_BATCH_FILE -P $port $args -o StrictHostKeyChecking=no -i $SSH_PRIVATE_KEY_FILE $username@$host

sudo rm $SSH_PRIVATE_KEY_FILE
sudo rm $SFTP_BATCH_FILE

echo 'Transfer completed successfully!'
exit 0
