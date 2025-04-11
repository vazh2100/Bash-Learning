#!/bin/bash
is_int_valid() case ${1#-} in ## Leading hyphen removed to accept negative numbers
*[!0-9]*) false ;;            ## the string contains a non-digit character
*) true ;;                    ## the whole number, and nothing but the number
esac
