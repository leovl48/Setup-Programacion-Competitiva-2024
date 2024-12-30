#!/usr/bin/env bash

for ((testNum=1;testNum<=$4;testNum++))
do
	./$3 > input
	./$2 < input > outSlow
	./$1 < input > outWrong
	if !(cmp -s "outSlow" "outWrong")
	then
		echo "Error found!"
		echo "Input:"
		cat input
		echo "Wrong Output:"
		cat outWrong
		echo "Slow Ouput:"
		cat outSlow
		exit
	else
		echo Passed $testNum
	fi
done

echo Passed $4 tests
