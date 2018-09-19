#!/bin/bash
	

	# this script is compiled just for answering question 3 of problem-set2 (https://github.com/CompTools/PS2-plantsruleantsdrool) for class zoo6927
	

	######################Important: please read following before executing the script###############################
	#Please make sure the data file "flights.May2017-Apr2018.csv" in under folder "data"

#Look for unique airport code in Origin column, write to unique.txt	
cat ./data/flights.May2017-Apr2018.csv|sed '1d'|cut -f3 -d','|sort|uniq > unique.txt

#Look for unique airport code in Destination column, append to unique.txt
cat ./data/flights.May2017-Apr2018.csv|sed '1d'|cut -f7 -d','|sort|uniq >> unique.txt

#sort by unique entry, write to output.txt
sort unique.txt|uniq >output.txt

cat ./output.txt
rm unique.txt
rm output.txt



