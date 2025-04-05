#!/bin/bash

# Write a script that asks the user to enter a number between 20
# and 30. If the user enters an invalid number or a non-number, ask
# again. Repeat until a satisfactory number is entered.

while true; do
  echo 'Enter a number between 20 and 30'
  read -r input
  if [[ ! $input =~ ^[0-9]+$ ]]; then
    echo "$input not a number"
  elif ((input > 30)); then
    echo "$input greater than 30"
  elif ((input < 20)); then
    echo "$input lesser than 20"
  else
    echo "You are good boy"
    break
  fi
done
