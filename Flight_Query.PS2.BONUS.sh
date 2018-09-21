#!/bin/bash

echo -n "Please enter either airport code (e.g. JFK) or city, state (e.g. Baltimore, MD) (case-sensitive) -> "

read input

if [["$input" =~ \b[A-Z]{3}\b] || [A-Z].+\,\s[A-Z]{2}]]; then
  grep -w "$input" ./data/flights.May2017-Apr2018.csv | cut -d "," -f 13,16 | grep -c 1.00
  
else
    echo "Invalid input, program terminated"
	exit
fi


