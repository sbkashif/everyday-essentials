average: 

awk 'NR>10000 {sum += $6; count++} END {if (count > 0) print sum/count}' prod_out.txt
