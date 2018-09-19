#!/bin/bash

# this script is compiled just for answering question 2 of problem-set2 (https://github.com/CompTools/PS2-plantsruleantsdrool) for class ZOO6927


# Set count to zero
count=0


# filter the whole data only containing 5 columns that we are interested in ""ORIGIN","DEST","DEP_DEL15","ARR_DEL15","WEATHER_DELAY""
cat ./data/flights.May2017-Apr2018.csv|sed '1d'|grep "GNV"|cut -f3,7,13,16,24 -d','| sed '1 i "ORIGIN","DEST","DEP_DEL15","ARR_DEL15","WEATHER_DELAY"'|while read ORIGIN DEST DEP_DEL15 ARR_DEL15 WEATHER_DELAY; do
ORIGIN=$(echo $ORIGIN $DEST $DEP_DEL15 $ARR_DEL15 $WEATHER_DELAY|cut -f1 -d',')  #define a variable that only includes origin
DEST=$(echo $ORIGIN $DEST $DEP_DEL15 $ARR_DEL15 $WEATHER_DELAY|cut -f2 -d',') #define a variable that only includes destination
DEP_DEL15=$(echo $ORIGIN $DEST $DEP_DEL15 $ARR_DEL15 $WEATHER_DELAY|cut -f3 -d',') #define a variable that only include delayed more than 15 minutes out of Gainesville
ARR_DEL15=$(echo $ORIGIN $DEST $DEP_DEL15 $ARR_DEL15 $WEATHER_DELAY|cut -f4 -d',') #define a variable that only include delayed more than 15 minutes into Gainesville


if [[ $DEST = ALT ]]; then
	count=$((count + 1)) #calcuating the flights that fit the above condition
	echo $count >>1A_count.txt #output the counting from the loop to a tmp file
	#echo "YES"
fi
# Set count to zero
count=0

if [[ $DEST =  CLT ]]; then
	count=$((count + 1)) #calcuating the flights that fit the above condition
	echo $count >>2A_count.txt #output the counting from the loop to a tmp file
	#echo "YES"
fi
# Set count to zero
count=0

if [[ $DEST =  MIA ]]; then
	count=$((count + 1)) #calcuating the flights that fit the above condition
	echo $count >>3A_count.txt #output the counting from the loop to a tmp file
	#echo "YES"
fi
# Set count to zero
count=0

if [[ $DEST =  ALT ]] && [[ $DEP_DEL15 = 1.00 || $ARR_DEL15 = 1.00 ]]; then
	count=$((count + 1)) #calcuating the flights that fit the above condition
	echo $count >>1B_count.txt #output the counting from the loop to a tmp file
	#echo "YES"
fi
# Set count to zero
count=0
if [[ $DEST =  CLT ]] && [[ $DEP_DEL15 = 1.00 || $ARR_DEL15 = 1.00 ]]; then
	count=$((count + 1)) #calcuating the flights that fit the above condition
	echo $count >>2B_count.txt #output the counting from the loop to a tmp file
	#echo "YES"
fi
# Set count to zero
count=0
if [[ $DEST =  MIA ]] && [[ $DEP_DEL15 = 1.00 || $ARR_DEL15 = 1.00 ]]; then
	count=$((count + 1)) #calcuating the flights that fit the above condition
	echo $count >>3B_count.txt #output the counting from the loop to a tmp file
	#echo "YES"
fi
# Set count to zero
count=0
done
tail -1 1A_count.txt 
\t 
tail -1 1B_count.txt \t
tail -1 1C_count.txt \n
tail -1 2A_count.txt \t tail -1 2B_count.txt \t tail -1 2C_count.txt \n
tail -1 3A_count.txt \t tail -1 3B_count.txt \t tail -1 3C_count.txt \n

