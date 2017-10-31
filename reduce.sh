#!/bin/bash
awk '{print $1,$2,$3,$4,$5,$6}' Run > Run_b
uniq Run_b > Run_clean
rm Run_b
sed '1,500d' Run_clean > Run_reduced
rm Run_clean
k = $(wc -l < theend$1.txt)
echo "$k" >> situazione.txt
./meanandvar < Run_clean 3 >> situazione.txt


