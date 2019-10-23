#!/bin/sh

touch cronCopy
chmod 777 cronCopy
    while [ true ]
    do
    # Display the menu
	echo "----------------------"
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
	if [ ${#num} -ne 1 ]
	then
    		echo "Error: Incorrect input: $num"
    		continue
    	fi
		
		
		
    	# Display all jobs.
    	if [ $num -eq 1 ]
		then
			# Update cronCopy with content of crontab
			crontab -l > cronCopy;
				# Checks for content in cronCopy
				if [ -s cronCopy ]
				then
					# Outputs the command with the following times and dates
					echo "The following command: "; awk '{ print$6 }' cronCopy;
					echo "will run on "; awk '{ print$1 }' cronCopy; echo "minute(s)";
					awk '{ print$2 }' cronCopy; echo "hour(s)"; awk '{ print$3 }' cronCopy;
					echo "day of month "; awk '{ print$4 }' cronCopy; echo "month"; 
					awk '{ print$5 }' cronCopy; echo "day of week";
				else
					echo "No Jobs to Display.";
				fi
		
				
				
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
			# Redirecting stderr and stdout for the case of non-existing crontab
			crontab -l > cronCopy;
			# Using quotes to catch the asterixes '*'
			echo "$minutes $hour $day $month $weekDay $user_command" >> cronCopy;
			# Update crontab file
			crontab -i cronCopy;
				echo "Job inserted";
				
				
				
	# Edit a job.
	elif [ $num -eq 3 ]
	then
		# Prompt for command to edit
		echo "Enter the name of the command to be edited: ";
		read commandEdit;
		# Update cronCopy with content of crontab
		crontab -l > cronCopy;
		# Search for a the given command
		while read line; 
		do 
			if echo "$line" | grep -q "$commandEdit"
			then
				echo "Command exists"
			fi
		done < cronCopy
		# Prompt for input
		echo 'Enter minutes ( 0 - 59 ) | * for any'; read minutes
		echo 'Enter hour ( 0 - 23 ) | * for any:'; read hour
		echo 'Enter the day ( 1 - 31 ) | * for any:'; read day
		echo 'Enter day of month ( 1 - 12 ) | * for any:'; read month
		echo 'Enter weekday ( 0 - Sun, 1 - Mon ) | * for any:'; read weekDay
		echo 'Enter command to install'; read user_command
			
			
			
			
			
		# Update crontab file
		crontab -i cronCopy;
			echo "Job successfully edited";
			
			
			
    	# Remove a job.
		elif [ $num -eq 4 ]
		then
			# Prompt for command to delete
			echo "Enter the name of the command to be deleted: ";
			read commandDel;
			# Update cronCopy with content of crontab
			crontab -l > cronCopy;
			# Remove the command and update crontab file
			sed -i "/$commandDel/d" cronCopy;
			crontab -i cronCopy;
			echo "Job deleted successfully."
		
		
		
    	# Remove all jobs.
    	elif [ $num -eq 5 ]
    	then
			crontab -r >/dev/null 2>&1;
    		echo "All jobs removed"
			
			
			
    	# Exit the while loop.
    	elif [ $num -eq 9 ]
    	then
    		break
			
			
			
    	# Error if command is not listed.
    	else
    		echo "Error: command number $num is not listed."
    	fi
		
		
    done
rm cronCopy;
echo "Exit successfull!"
