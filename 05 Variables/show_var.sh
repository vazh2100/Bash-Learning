#!/bin/bash
if [[ ${x+X} = X ]]; then ## If $x is set
  if [[ -n $x ]]; then    ## if $x is not empty
    printf "\$x = %s\n" "$x"
  else
    printf "\$x is set but empty\n"
  fi
else
  printf "%s is not set\n" "\$x"
fi
