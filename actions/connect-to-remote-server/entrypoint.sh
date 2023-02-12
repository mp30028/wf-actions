#!/bin/bash 

username=$0
password=$1
server=$2

command curl -k sftp://$server --user $username:$password
