#!/bin/sh

touch cronCopy
chmod 777 cronCopy
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
	if [ $((num)) != $num ]
	then
    		echo "Error: $num is not a number."
    		continue
    	fi
    	# Display all jobs.
    	if [ $num -eq 1 ]
    	then
		echo 'Displaying...'
    	# Insert a job.	
    	elif [ $num -eq 2 ]
	then
		# Prompt for input
		echo 'Enter minutes ( 0 - 59 ) | * for any'; read minutes
		echo 'Enter hour ( 0 - 23 ) | * for any:'; read hour
		echo 'Enter the day ( 1 - 31 ) | * for any:'; read day
		echo 'Enter day of month ( 1 - 12 ) | * for any:'; read month
		echo 'Enter weekday ( 0 - Sun, 1 - Mon ) | * for any:'; read weekDay
		echo 'Enter command to install'; read user_command
		# Update cronCopy with content of crontab 
		crontab -l > cronCopy;
		# Using quotes to catch the asterixes '*'
		echo "$minutes $hour $day $month $weekDay $user_command" >> cronCopy;
		# Update crontab file
		crontab -i cronCopy;
    		echo "Inserted";
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
