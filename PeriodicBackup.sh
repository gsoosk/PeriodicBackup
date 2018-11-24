#!/bin/bash
#Title = Qualification Project 
#Author = Farzad Habibi
#Porpuse = Back up from Source dir to Destination dir
#Created on 17 Tir


clear
a=1
b=2
while [ $a -lt  $b ] #an infinite loop
do
	echo
	echo "Menu, Just select one!"
	echo "1)Show files need to back up"
	echo "2)Set a back up progress in a period of time"
	echo "3)Help"
	echo "4)Quit"
	read cm
	clear

	if [ $cm == 1 ]
	then 
		#Here we get source and destination to show files should be copy
		echo "enter source directory:(you can type . insted of current directory)"
		read srcDir #A directory like : /Users/farzad/Desktop
		echo "enter destination directory:(you can type . insted of current directory)"
		read dstDir
		clear
		echo "----------------------------"
		rsync -avn $srcDir/* $dstDir #We use rsync that just copy modified and changed files
								   # "rysync options src dst"
								   # a : archive mode
								   # v : means verbose, showing details of ongoing operations
								   # n : --dry-run or -n enables us to execute a test operation without making any changes
								   # here we use -n to just show the files to copy
		echo "----------------------------"

	elif [ $cm == 2 ]
	then 
		echo "enter source directory (you can type . insted of current directory):"
		read srcDir
		echo "enter destination directory (you can type . insted of current directory):"
		read dstDir
		echo "enter period you want to get backup in minute:"
		read periodTime
		echo "enter number of period you want to pass"
		echo "(if you want an infinite backup just type 'infinite' ):"
		read periodNum
		clear

		i=-1
		j=$periodNum
		timeToSleep=`expr $periodTime \* 60`

		if [ $periodNum == "infinite" ]
		then
			j=0
		fi

		while [ $i -lt $j ]
		do 
			clear
			rsync -av $srcDir/* $dstDir > tmpFile.txt #Here copy files (for more info go to line 26)
			#Show the progress of backup
			date
			echo "*******"
			cat tmpFile.txt
			echo "*******"
			echo "Program is backuping now."

			#here we fill log file  
			echo "----------------------------" >> backup.logs
			date >> backup.logs
			echo "*******">> backup.logs
			cat tmpFile.txt >> backup.logs
			echo "----------------------------" >> backup.logs

			rm tmpFile.txt
			sleep $timeToSleep 
			if [ $periodNum != "infinite" ]
			then 
				i=`expr $i + 1`
			fi
		done

	elif [ $cm == 3 ]
	then 
		clear
		echo "You can see files that should get backup from them with first command."
		echo "You can backup modified and changeed files from one directory to another in a period of time with second command."
		echo "All the backup and changes save to backup.logs file in program directory."
		
	elif [ $cm == 4 ]
	then 
		b=1
	fi



done
