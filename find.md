# Calculate the number of files 

find . -maxdepth 1 -type d ! -path . -exec sh -c 'echo -n "{}: "; find "{}" -type f | wc -l' \;

# Printing column values and timestamp to monitor production speed and see it will get completed in time

`find . -name "prod_out.txt" -exec sh -c '
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
' sh {} \;`
