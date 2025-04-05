#!/bin/bash

# Write a script that prompts the user to enter the name of a file.
# Repeat until the user enters a file that exists

while true; do
  echo 'Enter a file name:'
  read -r input
  if [ ! -f "$input" ]; then
    echo "$input not a file"
  else
    echo "You are good boy"
    break
  fi
done
