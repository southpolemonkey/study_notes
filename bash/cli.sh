#!/bin/bash
# https://unix.stackexchange.com/questions/129391/passing-named-arguments-to-shell-scripts

while getopts ":a:p:" opt; do
  case $opt in
    a) arg_1="$OPTARG"
    ;;
    p) p_out="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

printf "Argument p_out is %s\n" "$p_out"
printf "Argument arg_1 is %s\n" "$arg_1"

# .cli.sh -p hello -a bash