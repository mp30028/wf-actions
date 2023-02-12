#!/bin/bash 
 
# store arguments in the args array 
args=("$@") 

# get number of args 
numberOfArgs=${#args[@]} 

echo "Welcome. There were $numberOfArgs args found. Here they are"
 
# echo each arg   
for (( i=0;i<$numberOfArgs;i++ )); do 
    echo "$i - ${args[${i}]}" 
done