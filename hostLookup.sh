#!/bin/bash 

function help() {
	  echo -e "\nUsage:"
    echo -e "\nhostLookup [host] [wordlist_path]"
    echo -e "i.e. hostLookup megacorpone.com /usr/share/wordlists/rockyou.txt"
    exit 1
}


if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    help
fi

if [ -z "$1" ]
  then
    echo "Host is empty"
    help
fi

if [ -z "$2" ]
  then
    echo "Wordlist is empty"
    help
fi

host=$1
wordlist="$(cat $2)"

i=0
totalWords="$(echo "$wordlist" | wc -w)"
echo -ne '(0%)\r'

for word in $wordlist
do
	result="$(host $word.$1)"
	
	if [[ $result =~ "has address" ]]
	then
		echo "$result"
	fi

	i=$(($i + 1))
	n="$(echo "scale=3; $i/$totalWords" | bc -l)"
	n="$(echo "$n * 100" | bc | sed '$s/..$//')"
	echo -ne "($n%) ($i/$totalWords)\r"

done