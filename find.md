# Calculate the number of files 

find . -maxdepth 1 -type d ! -path . -exec sh -c 'echo -n "{}: "; find "{}" -type f | wc -l' \;
