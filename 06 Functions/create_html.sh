#!/bin/bash

## Global variables

prog_name=${0##*/}
version=1
prompt=" ==> "
template='<!DOCTYPE html>
<html lang="en">
 <head>
 <meta charset=utf-8>
 <title>%s</title>
 <link href="%s" rel="stylesheet">
 </head>
 <body>
 <h1>%s</h1>
 <div id=main>
 </div>
 </body>
</html>
'

## Functions

# Prints error message and exit with error code
die() {
  local error=$1
  shift
  [ -n "$*" ] && printf "%s\n" "$*" >&2
  exit "$error"
}

# Prints script's usage information
usage() {
  printf "USAGE: %s HTMLFILE\n" "$prog_name"
}

# Print script's version information
version() { #@
  #@ USAGE: version
  printf "%s version %s" "$prog_name" "${version:-1}"
}

#
read_line() {
  read -ep "${2:-"$prompt"}" -i "$3" "$1"
}

if [ $# -ne 1 ]; then
  usage
  exit 1
fi
filename=$1
read_line title "Page title: "
read_line h1 "Main headline: "
read_line css "Style sheet file: " "${filename%.*}.css"
printf "$template" "$title" "$css" "$h1" >"$filename"
