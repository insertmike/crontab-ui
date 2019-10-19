#!/bin/sh
    
    while [ true ]
    do
    	# Display the menu
    	echo "Welcome to mycrontab!"
    	echo "Choose one of the following commands by entering the appropriate number."
    	echo ""
    	echo "1. Display all crontab jobs." 
    	echo "2. Insert a job."
    	echo "3. Edit a job."
    	echo "4. Remove a job."
    	echo "5. Remove all jobs."
    	echo "9. Exit."
    	echo ""
    	echo "Select a command number:"
    	read num
    	echo ""
    	
    	# Check if input is not a number.
    	if [! $num != [0-9]* ]
    	then
    		echo "Error: $num is not a number."
    		continue
    	fi
    
    	# Display all jobs.
    	if [ $num -eq 1 ]
    	then
    		echo "Displayed"
    		crontab -l
    	# Insert a job.	
    	elif [ $num -eq 2 ]
    	then
    		echo "Inserted"
    	# Edit a job.
    	elif [ $num -eq 3 ]
    	then
    		echo "Editted"
    	# Remove a job.
    	elif [ $num -eq 4 ]
    	then
    		echo "Removed"
    	# Remove all jobs.
    	elif [ $num -eq 5 ]
    	then
    		echo "RemovedAll"
    	# Exit the while loop.
    	elif [ $num -eq 9 ]
    	then
    		break
    	# Error if command is not listed.
    	else
    		echo "Error: command number $num is not listed."
    	fi
    	
    done
    echo "Exit successfull!"
