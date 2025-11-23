
# obtain the name of the cluster one is currently on
`hostname`

# print the working directories of currently running jobs

## command

`squeue --cluster=faculty -u $USER -h -o "%A" | xargs -I {} sh -c 'w=$(scontrol --cluster=faculty show job {} | awk -F= "/WorkDir/ {print \$2}"); printf "faculty {}: %s\n" "$(echo "$w" | rev | cut -d/ -f1-2 | rev)"'`

## pipe-by-pipe, option-by-option explanation via ChatGPT

### 🔹 Step 1 — `squeue --cluster="$CLUSTER" -u "$USER" -h -o "%A"`

This returns a **list of job IDs**, one per line.

#### **Options explained:**

* `--cluster="$CLUSTER"` → query that specific cluster
* `-u "$USER"` → only show your jobs
* `-h` → hide the header
* `-o "%A"` → output format: only the job ID (`%A`)

#### **Output example:**

```
20410435
20410434
20388707
...
```

---

### 🔹 Step 2 — `| xargs -I {} sh -c ' ... '`

This takes each job ID and runs the enclosed script block once per job.

* `xargs` → repeatedly run a command for each input line
* `-I {}` → placeholder `{}` will be replaced with the job ID
* `sh -c ' ... '` → run a small shell script dynamically

---

### 🔹 Step 3 —

#### `w=$(scontrol --cluster=faculty show job {} | awk -F= "/WorkDir/ {print \$2}")`

Breakdown:

* `scontrol show job <jobid>` → prints full job information

* `--cluster=<name>` → required for multi-cluster SLURM

* Output contains a line like:

  ```
  WorkDir=/scratch/salman/project/run12
  ```

* `awk -F=` splits on `=`

  * `$1 = WorkDir`
  * `$2 = /scratch/salman/project/run12`

* So we extract just the **working directory path**.

#### Example captured value (stored in `w`):

```
/scratch/salman/zeolite/ring_k
```

---

### 🔹 Step 4 — Trim to last N path components:

#### `trimmed=$(echo "$w" | rev | cut -d/ -f1-$NCOMP | rev)`

Breakdown:

* `rev` → reverse the string
* `cut -d/ -f1-$NCOMP` → select the first N fields from the reversed path
* `rev` again → restore original order

#### Example:

Full path:

```
/scratch/salman/zeolites/rings/ring_k
```

`NCOMP=2` → gives:

```
rings/ring_k
```

`NCOMP=3` → gives:

```
zeolites/rings/ring_k
```

---

### 🔹 Step 5 — Print formatted line:

#### `printf "%s %s: %s\n" "$CLUSTER" "{}" "$trimmed"`

Output example:

```
faculty 20410435: rings/ring_k
faculty 20410434: ring_k/run2
faculty 20388707: mem_li/task5
```

---

