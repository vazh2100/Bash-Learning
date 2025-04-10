#!/bin/bash

address=192.168.0.123
function getSecond {
  local result
  result=${address#*.}
  result="${result%%.*}"
  echo "$result"
}
getSecond
