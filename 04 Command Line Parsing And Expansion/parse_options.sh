#!/bin/bash
progName=${0##*/} ## Get the name of the script without its path
echo "$progName"
## Default values
isVerbose=0
fileName=""

while getopts "f:v" opt; do
  case $opt in
  f) fileName=$OPTARG ;; ## $OPTARG contains the argument to the option
  v) isVerbose=1 ;;
  *) exit 1 ;;
  esac
done

echo OPTIND "$OPTIND"

## Check whether a filename was entered
if [ -n "$fileName" ]; then
  if ((isVerbose)); then
    printf "Filename is %s\n" "$fileName"
  fi
else
  if ((isVerbose)); then
    printf "No filename entered\n" >&2
  fi
  exit 1
fi
## Check whether file exists
if [ -f "$fileName" ]; then
  if ((isVerbose)); then

    printf "Filename %s found\n" "$fileName"
  fi
else
  if ((isVerbose)); then
    printf "File, %s, does not exist\n" "$fileName" >&2
  fi
  exit 2
fi
## If the verbose option is selected,
## print the number of arguments remaining on the command line
if ((isVerbose)); then
  printf "Number of arguments is %d\n" "$#"
fi
