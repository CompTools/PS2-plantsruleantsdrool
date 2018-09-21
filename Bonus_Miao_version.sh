#!/bin/bash
# print options:enter either a airport code or city, state name
clear
echo "
Please Input Your Query:

#. 3 letter Airport Code
    or
#. City,State Name (seperated by ",")
    or
#. type "Quit" to exit
"
#define a function to valid Query

invalid_input () {
echo "Invalid input '$REPLY'" >&2
exit 1
}

read -p "Enter Your Query --> "

# input is empty (invalid)
[[ -z $REPLY ]] && invalid_input
# input is multiple items (invalid)
#(( $(echo $REPLY | wc -w) < 3 )) && invalid_input

if [[ $REPLY == Quit ]]; then
  echo "Program terminated."
  exit
fi

if [[ $REPLY =~ ^[A-Z]{3}$ ]]; then
  #echo -e "It's Airport Code: $REPLY"
  echo -e "Please wait ...\nThe number of delayed flights in or out of $REPLY is:"
  grep -w "$REPLY" ./data/flights.May2017-Apr2018.csv | cut -d "," -f 13,16 | grep -c 1.00
elif [[ $REPLY =~ ^[A-Z].*[A-Z]{2}$ ]]; then
  #echo -e "City,State Name: $REPLY"
  Query=$(echo "$REPLY"|sed 's/^/"/g;s/$/"/g')
  #echo $Query
  echo -e "Please wait ...\nThe number of delayed flights in or out of $REPLY is:"
  grep -w "$REPLY" ./data/flights.May2017-Apr2018.csv | cut -d "," -f 13,16 | grep -c 1.00
else
  invalid_input >&2
  exit 1
fi
