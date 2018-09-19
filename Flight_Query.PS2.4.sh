#!/bin/bash

# this script is compiled just for answering question 3 of problem-set2 (https://github.com/CompTools/PS2-plantsruleantsdrool) for class zoo6927
	

	######################Important: please read following before executing the script###############################
	#Please make sure the data file "flights.May2017-Apr2018.csv" in under folder "data"

#Capture all cities with FL
  grep ", FL" ./data/flights.May2017-Apr2018.csv > FL.txt

#Capture 4th column which has city names
  cut -d '"' -f 4 ./FL.txt > .FLairport.txt

#Print out into file
  grep "FL" .FLairport.txt | cut -d "," -f 1 | sort -u > airportinFL.txt
  cat airportinFL.txt

#clean up
rm FL.txt
rm airportinFL.txt
