## awk by 
awk 'BEGIN {FS=","} {print $3,$5 }' CANCEL_20181219143357.csv

awk 'BEGIN {FS=","} {NR>1} {print "@getCust3 " $3 }' CANCEL_20181219143357.csv > test__data.sql
