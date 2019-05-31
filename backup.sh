#!/bin/bash 

echo "#######################"
echo "Starting backup"
echo "#######################"

# The CSV file needs an extra line break at the end. 
# There isn't any error correcting or anything fun in here.

INPUT=devices.csv
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read ip name
do
	echo "SCP running config from $ip to $name.txt"
	scp $ip:running-config ./$name.txt
	echo "------------"
done < $INPUT
IFS=$OLDIFS

echo "#######################"
echo "Backup complete"
echo "#######################"

