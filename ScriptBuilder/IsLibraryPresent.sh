#!/bin/sh
#
# Course: CS 100 Summer Session II 2015
# First Name: Jonathan
# Last Name: Tan
# Username: jtan021
# Email Address: jtan021@ucr.edu
# SID: 861108230
#
# AssignmentID (e.g. lab0, lab1, ..., hw0, hw1, ...): HW0
# Filename:
#
# I hereby certify that the contents of this file represent
# my own original individual work. Nowhere herein is there
# code from any outside resources such as another individual,
# a website, or publishings unless specifically designated as 
# permissible by the instructor or TA.
# I also understand that by cheating, stealing, plagiarism or 
# any other form of academic misconduct defined at
# http://conduct.ucr.edu/policies/academicintegrity.html,
# the consequences will be an F in the class, and additional
# disciplinary sanctions, such as the dismissal from UCR.
#
#
# Name: isLibraryPresent.sh	
# Input: 1-Column File <$1>
# 	 Library Name <$2>
# Output: 1 or -1 if Libray name is present in file
# Note:  
#
#

if [ $# -ne 2 ]; then
	echo -e "Usage: $0 <Library File> <Library Name>"
	exit
fi

while read line
do
	if [ "$line" = "$2" ]; then
		echo "1"
		exit
	fi
done < $1

echo "-1"

