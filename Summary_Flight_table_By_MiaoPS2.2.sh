#!/bin/bash

#define a function that calculate GNV to:	Total flights
#Total flights delayed (>15min)
#Total flights delayed due to Weather
Summary_table(){
	count=0
	DEL15_count=0
	DEL_Wther_count=0

	while read line; do
		ORIGIN=$(echo $line|cut -f1 -d',')
		DEST=$(echo $line|cut -f2 -d',')
		DEP_DEL15=$(echo $line|cut -f3 -d',') #define a variable that only include delayed more than 15 minutes out of Gainesville
		ARR_DEL15=$(echo $line|cut -f4 -d',') #define a variable that only include delayed more than 15 minutes into Gainesville
		WEATHER_DELAY=$(echo $line|cut -f5 -d',')

		#checking departure airport and arrival airport
		if [[ $ORIGIN == GNV && $DEST == "$1" ]]; then
			#echo "yes"
			((count++))
			echo ${count} >>./temp/${1}_count.tmp
			#checking delay into and out GNV flights
			if [[ $DEP_DEL15 = 1.00 || $ARR_DEL15 = 1.00 ]]; then #making "or" decision that satisfying all the scenario based on the question
				((DEL15_count++)) #calculating the flights that fit the above condition
				echo ${DEL15_count} >>./temp/${1}_DEL15_count.tmp #output the counting from the loop to a tmp file
			fi

			#checking the flights delayed by weather
			if [[ "$WEATHER_DELAY" > "0.00" ]]; then #creating a condition that satisfying the weather delay
				#echo $WEATHER_DELAY
				((DEL_Wther_count++)) #counting the flights delayed by weather
				echo ${DEL_Wther_count} >>./temp/${1}_DEL_Wther_count.tmp #output the counting from the loop to a tmp file
			else
				echo "0" >>./temp/${1}_DEL_Wther_count.tmp
			fi
		fi
	done < "./temp/GNV_flight_info.tmp"
	echo -e "$1\t$(tail -1 ./temp/${1}_count.tmp)\t$(tail -1 ./temp/${1}_DEL15_count.tmp)\t$(tail -1 ./temp/${1}_DEL_Wther_count.tmp)" >>GNV_to_ATL_CLT_MIA_Flights.table
}

#create a table and header
echo -e "GNV to:\tTotal flights\tTotal flights delayed (>15min)\tTotal flights delayed due to Weather" >GNV_to_ATL_CLT_MIA_Flights.table

#get information from these three airpot ATL CLT MIA
for Airpot in ATL CLT MIA; do
	Summary_table $Airpot
done
# rm -fr ./temp/*count.tmp
exit
