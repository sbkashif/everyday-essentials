
## Obtain the name of the cluster one is currently on
`hostname`

## Print the working directories of currently running jobs

`squeue --cluster=faculty -u $USER -h -o "%A" | xargs -I {} sh -c 'w=$(scontrol --cluster=faculty show job {} | awk -F= "/WorkDir/ {print \$2}"); printf "faculty {}: %s\n" "$(echo "$w" | rev | cut -d/ -f1-2 | rev)"'`
