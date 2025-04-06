#!/bin/bash
secs_in_day=86400
secs_in_hour=3600
secs_in_min=60

days=$(($1 / secs_in_day))
seconds=$(($1 - days * secs_in_day))
hours=$((seconds / secs_in_hour))
seconds=$((seconds - hours * secs_in_hour))
minutes=$((seconds / secs_in_min))
seconds=$((seconds - minutes * secs_in_min))
printf "\r%d:%02d:%02d:%02d" "$days" "$hours" "$minutes" "$seconds"
