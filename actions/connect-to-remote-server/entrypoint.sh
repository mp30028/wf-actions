#!/bin/bash 

username=$1
password=$2
server=$3

# echo "server=$server, username=$username, password=$password"
command curl -k sftp://$server --user $username:$password
