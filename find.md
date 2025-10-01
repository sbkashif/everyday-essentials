# Calculate the number of files 

find . -maxdepth 1 -type d ! -path . -exec sh -c 'echo -n "{}: "; find "{}" -type f | wc -l' \;

# Printing column values and timestamp in OpenMM output file

## Purpose: See if the run would be completed in time for the number of hours the node is requested

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

# Sort directories numerically

find ../../gcmc_simulations/loadings/sar_1/calero/nh3/473K/ -maxdepth 1 -type d \
  ! -name "." \
| awk -F'/' '{print $(NF) "\t" $0}' \
| sort -g \
| cut -f2

# Sort directories numerically - clean

```bash
find . -maxdepth 1 -type d ! -name "." | sed 's|^\./||' | sort -g | sed 's|^|./|'
```

## explanation via <img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:32px;margin-right:16px"/>


***

### 1. Finding Directories in the Current Folder

```bash
find . -maxdepth 1 -type d
```

- `find`: A command-line tool for searching files and directories.[^1]
- `.`: Start the search from the current directory.
- `-maxdepth 1`: Only look one level deep, so results are all directories directly under the current location.
- `-type d`: Only list directories, not files.

*Example output:*

```
.
./1.000000000e+07
./1.000000000e-06
...
```


***

### 2. Removing the `./` Prefix for Numeric Sorting

```bash
sed 's|^\./||'
```

- `sed`: Stream editor for filtering and transforming text.
- `s|^\./||`: Substitute command that removes `./` from the start of each line.
    - `^`: Start of the line.
    - `\./`: Matches the literal `./`.

*Transforms output to:*

```
1.000000000e+07
1.000000000e-06
...
```


***

### 3. Numeric Sorting of Floating Point Values

```bash
sort -g
```

- `sort`: Standard command for sorting lines.
- `-g`: “General numerical sort,” which sorts lines based on their floating-point value (handles scientific notation, decimals, etc).

*This puts directory names like `1.321941148e-01` before `2.009233003e+00`, for example.*

***

### 4. Restoring the Path Prefix

```bash
sed 's|^|./|'
```

- `sed`: Again, used to modify text.
- `s|^|./|`: Adds `./` to the start of each line to restore the original directory path structure.

*Restores output to:*

```
./1.321941148e-01
./2.009233003e+00
...
```


***

### 5. Excluding Current Directory (Optional)

```bash
find . -maxdepth 1 -type d ! -name "."
```

- `! -name "."`: Excludes the `.` (current directory) from the results.

***
```bash
find . -maxdepth 1 -type d ! -name "." | sed 's|^\./||' | sort -g | sed 's|^|./|'
```

- Lists all directories, strips the prefix, sorts numerically, and restores the prefix for usability.

***
