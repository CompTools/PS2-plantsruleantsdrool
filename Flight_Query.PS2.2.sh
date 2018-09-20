#!/bin/bash

# this script is compiled just for answering question 2 of problem-set2 (https://github.com/CompTools/PS2-plantsruleantsdrool) for class ZOO6927

######################Important: please read following before executing the script###############################
	#Please make sure the data file "flights.May2017-Apr2018.csv" in under folder "data"

# Set count to zero
countaa=0
countab=0
countac=0
countba=0
countbb=0
countbc=0
countca=0
countcb=0
countcc=0


# filter the whole data only containing 5 columns that we are interested in ""ORIGIN","DEST","DEP_DEL15","ARR_DEL15","WEATHER_DELAY""
cat ./data/flights.May2017-Apr2018.csv|sed '1d'|grep "GNV"|cut -f3,7,13,16,24 -d','| sed '1 i "ORIGIN","DEST","DEP_DEL15","ARR_DEL15","WEATHER_DELAY"' > new.flights.csv
while IFS= read -r line; do
ORIGIN=$(echo $line|cut -f1 -d',')  #define a variable that only includes origin
DEST=$(echo $line|cut -f2 -d',') #define a variable that only includes destination
DEP_DEL15=$(echo $line|cut -f3 -d',') #define a variable that only include delayed more than 15 minutes out of Gainesville
ARR_DEL15=$(echo $line|cut -f4 -d',') #define a variable that only include delayed more than 15 minutes into Gainesville
WEATHER_DELAY=$(echo $line|cut -f5 -d',') #define a variable that only includes weather delays

# Calculate column 1 values
if [[ $ORIGIN == "\"GNV\"" && $DEST == "\"ATL\"" ]]; then
	countaa=$((countaa + 1)) #calcuating the flights that fit the above condition
	echo $countaa >>aa_count.txt #output the counting from the loop to a tmp file
fi

if [[ $ORIGIN == "\"GNV\"" && $DEST == "\"CLT\"" ]]; then
	countab=$((countab + 1)) #calcuating the flights that fit the above condition
	echo $countab >>ab_count.txt #output the counting from the loop to a tmp file
fi

if [[ $ORIGIN == "\"GNV\"" && $DEST == "\"MIA\"" ]]; then
	countac=$((countac + 1)) #calcuating the flights that fit the above condition
	echo $countac >>ac_count.txt #output the counting from the loop to a tmp file
fi
# Calculate column 2 values
if [[ $ORIGIN == "\"GNV\"" && $DEST == "\"ATL\"" ]] && [[ $DEP_DEL15 = 1.00 ]] || [[ $ARR_DEL15 = 1.00 ]]; then
		countba=$((countba + 1)) #calcuating the flights that fit the above condition
		echo $countba >>ba_count.txt #output the counting from the loop to a tmp file	
fi

if [[ $ORIGIN == "\"GNV\"" && $DEST == "\"CLT\"" ]] && [[ $DEP_DEL15 = 1.00 ]] || [[ $ARR_DEL15 = 1.00 ]]; then
		countbb=$((countbb + 1)) #calcuating the flights that fit the above condition
		echo $countbb >>bb_count.txt #output the counting from the loop to a tmp file
fi

if [[ $ORIGIN == "\"GNV\"" && $DEST == "\"MIA\"" ]] && [[ $DEP_DEL15 = 1.00 ]] || [[ $ARR_DEL15 = 1.00 ]]; then
		countbc=$((countbc + 1)) #calcuating the flights that fit the above condition
		echo $countbc >>bc_count.txt #output the counting from the loop to a tmp file
fi
# Calculate column 3 values
if [[ $ORIGIN == "\"GNV\"" && $DEST == "\"ATL\"" ]] && [[ $WEATHER_DELAY > 0.00 ]]; then
        countca=$((countca + 1)) #calcuating the flights that fit the above condition
        echo $countca >>ca_count.txt #output the counting from the loop to a tmp file
fi

if [[ $ORIGIN == "\"GNV\"" && $DEST == "\"CLT\"" ]] && [[ $WEATHER_DELAY > 0.00 ]]; then
        countcb=$((countcb + 1)) #calcuating the flights that fit the above condition
        echo $countcb >>cb_count.txt #output the counting from the loop to a tmp file  
fi

if [[ $ORIGIN == "\"GNV\"" && $DEST == "\"MIA\"" ]] && [[ $WEATHER_DELAY > 0.00 ]]; then
        countcc=$((countcc + 1)) #calcuating the flights that fit the above condition
        echo $countcc >>cc_count.txt #output the counting from the loop to a tmp file
fi
done < new.flights.csv
# Print the table by column
echo "column 1"
tail --lines=1 -n 1 -q aa_count.txt ab_count.txt ac_count.txt 
echo "column 2"
tail --lines=1 -n 1 -q ba_count.txt bb_count.txt bc_count.txt
echo "column 3"
tail --lines=1 -n 1 -q ca_count.txt cb_count.txt 
echo "0"

# Remove temp files
rm aa_count.txt
rm ba_count.txt
rm ca_count.txt 
rm ab_count.txt
rm bb_count.txt
rm cb_count.txt 
rm ac_count.txt
rm bc_count.txt
