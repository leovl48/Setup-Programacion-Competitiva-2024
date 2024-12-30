#!/usr/bin/env bash

case=""
input=()
results=()
outCase=""

while IFS= read -r line; do
	if [[ $line == "$" ]]; then
		outCase+="$(echo "$case" | ./$1)"$'\n'
		outCase=$(echo "$outCase" | sed 's/[[:space:]]*$//')
		results+=("$outCase")
		input+=("$case")
		outCase=""
		case=""
	else
		if [ "${#case}" -ne 0 ]; then
			case+=$'\n'
		fi
		line=$(echo "$line" | sed 's/[[:space:]]*$//')
		case+="$line"
	fi
done < $2

len=${#results[@]}
pos=0

while IFS= read -r line ; do
	if [[ $line == "$" ]]; then
		if [ "$pos" -ge "$len" ]; then
			echo "Error found!"
			echo "Some test cases are missing"
			echo "User output: Very small"
			exit
		fi
		user_output=${results[$pos]}
		if [[ "$user_output" != "$case" ]]; then
			echo "Error found!"
			echo "Input:"
			echo "${input[$pos]}"
			echo "Wrong Output:"
			echo "${results[$pos]}"
			echo "Expected Output:"
			echo "$case"
			exit
		fi
		((pos++))
		case=""
	else
		if [ "${#case}" -ne 0 ]; then
			case+=$'\n'
		fi
		line=$(echo "$line" | sed 's/[[:space:]]*$//')
		case+="$line"
		
	fi
done < $3

if [ "$pos" -lt "$len" ]; then
	echo "Error found!"
	echo "Some test cases are missing"
	echo "User output: Very large"
	exit
fi

echo "Samples Passed"
