#!/bin/bash

# this script is complied just for answering question 1 of problem-set2 (https://github.com/CompTools/PS2-plantsruleantsdrool) for class zoo6927

######################Important:please read following befor excuteing the script###############################
#Please make sure the data file "flights.May2017-Apr2018.csv" in under folder "data"

#1. Counts the number of flights that were delayed more than 15 minutes into or out of Gainesville, FL (airport code GNV) 
#during the timeframe covered by the dataset. (2 points)

#set the count start from "0"
count=0

#filter the whole data only containing 5 columns that we intersted ""ORIGIN","DEST","DEP_DEL15","ARR_DEL15","WEATHER_DELAY""
cat ./data/flights.May2017-Apr2018.csv|sed '1d'|grep "GNV"|cut -f3,7,13,16,24 -d','| sed '1 i "ORIGIN","DEST","DEP_DEL15","ARR_DEL15","WEATHER_DELAY"' |while read ORIGIN DEST DEP_DEL15 ARR_DEL15 WEATHER_DELAY; do
DEP_DEL15=$(echo $ORIGIN $DEST $DEP_DEL15 $ARR_DEL15 $WEATHER_DELAY|cut -f3 -d',') #define a variable that only include delayed more than 15 minutes out of Gainesville
ARR_DEL15=$(echo $ORIGIN $DEST $DEP_DEL15 $ARR_DEL15 $WEATHER_DELAY|cut -f4 -d',') #define a variable that only include delayed more than 15 minutes into Gainesville
#echo $ARR_DEL15
if [[ $DEP_DEL15 = 1.00 || $ARR_DEL15 = 1.00 ]]; then #making "or" decision that satisfying all the scenario based on the question
	count=$((count + 1)) #calcuating the flights that fit the above condition
	echo $count >>tmp_count.txt #output the counting from the loop to a tmp file
	#echo "YES"
fi
#echo $count
	#echo $ORIGIN $DEST $DEP_DEL15 $ARR_DEL15 $WEATHER_DELAY
done
echo -e "The number of flights that were delayed more than 15 minutes into or out of Gainesville is:"
tail -1 tmp_count.txt
rm  tmp_count.txt