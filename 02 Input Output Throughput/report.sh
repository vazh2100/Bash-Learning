#!/bin/bash
# shellcheck disable=SC2059

# Description : print formatted sales report
# Build a long string of equals signs
LC_NUMERIC=C
divider="===================================="
divider=$divider$divider
## Format strings for printf
header="%-10s %11s %8s %10s\n"
format="%-10s %11.2f %8d %10.2f\n"
## Width of divider
total_width=42
## Print categories
printf "$header" "ITEM" "PER UNIT" "NUM" "TOTAL"
## Print divider to match width of report
printf "%${total_width}.${total_width}s\n" "$divider"
## Print lines of report
printf "$format" \
  Chair 79.95 4 319.8 \
  Table 209.99 1 209.99 \
  Armchair 315.49 2 630.98
