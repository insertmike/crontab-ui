#!/bin/bash

# permissions config
chmod u+x coursework.sh
chmod u+x custom_cron_job.txt

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
	read -p "Select a command number: " num # Read user input, accept only one character input
	echo ""

	# Check for integer input
	if [ ${#num} -ne 1 ]											# Validate for 1 char input
	then
		if [ ! $num == [0-9] ]									# Validate for char to be a digit
		then
			echo "incorrect input"								# Print Error Message
			continue															# Restart loop
		fi
	fi

	# Display all jobs
	if [ $num -eq 1 ]													# Validate input number '1'
	then
		echo "Active jobs"
		crontab -l															# Print jobs with crontab -l
	fi

	# --- Insert jobs
	if [ $num -eq 2 ]													# Validate input number '1'
	then
		echo "Insert new jobs"

		# Prompt for input
		echo 'Enter minutes ( 0 - 59 ) | * for any'; read minutes
		echo 'Enter hour ( 0 - 23 ) | * for any:'; read hour
		echo 'Enter the day ( 1 - 31 ) | * for any:'; read day
		echo 'Enter day of month ( 1 - 12 ) | * for any:'; read month
		echo 'Enter weekday ( 0 - Sun, 1 - Mon ) | * for any:'; read weekDay
		echo 'Enter command to install'; read user_command

		# Using quotes to catch the asterixes '*'
		# capture job config to custom crontab file
		echo "$minutes $hour $day $month $weekDay $user_command" >> custom_cron_job.txt;

		# pass the parameters of custom config file to 'crontab'
		crontab custom_cron_job.txt
    echo "Job inserted" 										# check message
	fi
	# --- END

	# --- Remove all jobs
	if [ $num -eq 5 ]													# Validate input number '5'
	then
		echo "Removing all jobs"
		crontab -r															# Remove all 'crontab' active jobs
		rm custom_cron_job.txt									# Delete jobs from 'crontab' custom file
	fi
	# --- END

done

# Exit crontab
echo "Exit successfull!" 										# Exit message
