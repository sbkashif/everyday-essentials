#!/bin/bash

find . -name "prod_out.txt" -exec sh -c '
  dir=$(dirname "$1")
  xml_file="$dir/prod_initial_state.xml"
  echo "File: $1"
  if [ -f "$xml_file" ]; then
    mod_time=$(stat -c %y "$xml_file")
    echo "Modification time of XML file: $mod_time"
  else
    echo "Modification time of XML file: Not found"
  fi
  tail_line=$(tail -n 1 "$1")
  second_col=$(echo "$tail_line" | awk "{print \$2}")
  last_col=$(echo "$tail_line" | awk "{print \$NF}")
  echo "2nd column: $second_col, Last column: $last_col"
' sh {} \;
