#!/bin/bash 

username=$1
password=$2
host=$3
server_filepath=$4
source_filepath=$5

curl -k sftp://$host$server_filepath --user $username:$password -T $source_filepath --ftp-create-dirs