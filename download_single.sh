#!/bin/bash
sshpass -p "#password" ssh #uname@login.marconi.cineca.it 'cd #directory ; rm lista;  ls -d */ | grep -v "backup" >> lista ; exit'
sshpass -p "#password" scp -r -v #uname@login.marconi.cineca.it:#directory/lista .
for i in $(cat lista); do
        echo "processing $i file"
	sshpass -p "#password" scp -r -v #uname@login.marconi.cineca.it:#directory/$i .
done




