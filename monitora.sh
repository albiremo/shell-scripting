#!/bin/bash
i=0
echo "pulisco i Run e la situazione"
rm -v Run*
rm -v situazione.txt
sshpass -p "#pass" ssh #uname@login.marconi.cineca.it 'cd #dir ; rm lista_casi;  ls -d */  >> lista_casi ; exit'
sshpass -p "#pass" scp -r -v #uname0@login.marconi.cineca.it:#dir .
for j in $(cat lista_casi); do
 let i++
 sshpass -p "#pass" scp -r -v #uname@login.marconi.cineca.it:#dir/reference_speed/$j'Run' .
 cp -v Run Run_$i
 echo "$j" >> situazione.txt
 ./meanandvar < Run_$i 3 >> situazione.txt
done
