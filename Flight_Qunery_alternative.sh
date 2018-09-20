#!/bin/bash
#The goal of this project is to write a Bash script that:
#
#Counts the number of flights that were delayed more than 15 minutes into or out of Gainesville, FL (airport code GNV) 
#during the timeframe covered by the dataset. (2 points)
cat data/flights.May2017-Apr2018.csv |grep "GNV"|cut -f13,16 -d','|grep "1"|wc -l
#950
#Produces a table (text is fine) with the data to fill in this table (13 points):
#GNV to:	Total flights	Total flights delayed (>15min)	Total flights delayed due to Weather
#ATL			
#CLT			
#MIA			
#:	Total flights
cat data/flights.May2017-Apr2018.csv |grep "GNV"|cut -f3,7 -d','|sort|uniq -c
   1475 "ATL","GNV"
    476 "CLT","GNV"
   1476 "GNV","ATL"
    476 "GNV","CLT"
    205 "GNV","MIA"
    206 "MIA","GNV"
#Total flights delayed (>15min)
cat data/flights.May2017-Apr2018.csv |grep "GNV"|cut -f3,7,13 -d','|grep "1"|sort|uniq -c 
    262 "ATL","GNV",1.00
    112 "CLT","GNV",1.00
    262 "GNV","ATL",1.00
    107 "GNV","CLT",1.00
     30 "GNV","MIA",1.00
     30 "MIA","GNV",1.00
#Total flights delayed due to Weather
cat data/flights.May2017-Apr2018.csv |grep "GNV"|cut -f3,7,24 -d','|grep [1-9]|cut -f1,2 -d','|sort|uniq -c
     16 "ATL","GNV"
     13 "CLT","GNV"
     15 "GNV","ATL"
      3 "GNV","CLT"
      1 "MIA","GNV"
#Within a function, prints a list of all unique airport codes contained in the dataset. (3 points)
##	 We observed only ""ORIGIN" and "DEST" columns containing the Airport code, so
cat data/flights.May2017-Apr2018.csv|sed '1d'|cut -f3,7 -d','|sed 's/"//g;s/,/\n/g'|sort|uniq >all_unique_airport_code.txt

#Within a function lists the cities in Florida that have airports in the dataset. (2 points)
##	the 4th column "ORIGIN_CITY_NAME"
cut -f4,5 -d',' data/flights.May2017-Apr2018.csv|grep "FL"|sed 's/"//g'|sort|uniq|cut -f1 -d',' >Airport_in_Florida_Cities.txt
#Bonus question: Asks for user input (see chapter 28) to enter either a airport code or city, state name and then calculates 
#the number of flights as in question 1. (5 points extra credit)
