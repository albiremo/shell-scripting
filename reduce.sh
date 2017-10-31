#!/bin/bash
rm Run_reduced
awk '{print $1,$2,$3,$4,$5,$6}' Run > Run_b
uniq Run_b > Run_clean
rm Run_b
sed "1,5000d" Run_clean > Run_reduced
rm Run_clean
LINES=$(wc -l < Run_reduced)
echo $LINES
echo "$LINES" >> situazione.txt
./meanandvar < Run_reduced 3 >> situazione.txt


