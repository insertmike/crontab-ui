#!/bin/sh

touch cronCopy
chmod 777 cronCopy

while [ true ]
  do

  # ------------------
  # [Display the menu]
  # ------------------

	echo "----------------------"
	echo "Welcome to mycrontab!"
	echo "Choose one of the following commands by entering the appropriate number."
  echo "--"
	echo "1. Display all crontab jobs."
	echo "2. Insert a job."
  echo "3. Edit a job."
	echo "4. Remove a job."
	echo "5. Remove all jobs."
	echo "9. Exit."
	echo ""
	read -p "Select a command number: " num
	echo ""

  # ------------------
  # [Input validation]
  # ------------------

  #validate for 1 char input
  if [ ${#num} -ne 1 ]
  then
		#validate for char to be a digit
    if [ ! $num == [0-9] ]
    then
      echo ""
      echo "Error: Incorrect input: $num"
      echo ""
      continue
    fi
  fi

  # ------------------------
  # [Menu commands handling]
  # ------------------------

  # -----------------
	# Display all jobs
  # -----------------

	if [ $num -eq 1 ]
	then

    #update cronCopy with content of crontab
    crontab -l > cronCopy;

    #checks for content in cronCopy
		if [ -s cronCopy ]
		then
			cat cronCopy | while read min hour day month weekDay cm
			do
				printf "Command: %s. Running: on %s day of week, %s month, %s day of month, %s hour, %s min \n" "$cm" "$weekDay" "$month" "$day" "$hour" "$min"
			done
		else
      echo ""
			echo "No Jobs to Display";
      echo ""
		fi

  # ------------
	# Insert a job
  # ------------

	elif [ $num -eq 2 ]
   then

	# Prompt for command settings input
	echo 'Enter minutes ( 0 - 59 ) | * for any'; read minutes
	echo 'Enter hour ( 0 - 23 ) | * for any:'; read hour
	echo 'Enter the day ( 1 - 31 ) | * for any:'; read day
	echo 'Enter day of month ( 1 - 12 ) | * for any:'; read month
	echo 'Enter weekday ( 0 - Sun, 1 - Mon ) | * for any:'; read weekDay
	echo 'Enter command to install'; read user_command

	# Using quotes to catch the asterixes '*'
	echo "$minutes $hour $day $month $weekDay $user_command" >> cronCopy;

	# Update crontab file
	crontab cronCopy
	echo "Job inserted"

  # ----------
	# Edit a job
  # ----------

	elif [ $num -eq 3 ]
	then

    #prompt for command to edit
		read -p "Enter the name of the command to be edited: " commandEdit

    #search for a given command in cronCopy
    while read line;
		do
			if echo "$line" | grep -q "$commandEdit" #locate command
			then

	      #remove the command and update crontab file
        sed -i "/$commandEdit/d" cronCopy
    		crontab cronCopy
		    echo "Command exists"

			fi
    #read-in filename cronCopy
		done < cronCopy

    # Prompt for new command input
		echo 'Enter minutes ( 0 - 59 ) | * for any'; read minutes
		echo 'Enter hour ( 0 - 23 ) | * for any:'; read hour
		echo 'Enter the day ( 1 - 31 ) | * for any:'; read day
		echo 'Enter day of month ( 1 - 12 ) | * for any:'; read month
		echo 'Enter weekday ( 0 - Sun, 1 - Mon ) | * for any:'; read weekDay
		echo 'Enter command to install'; read user_command

    # Using quotes to catch the asterixes '*'
    echo "$minutes $hour $day $month $weekDay $user_command" >> cronCopy;

    # Update crontab file
    crontab cronCopy;
		echo "Job successfully edited";

  # ------------
	# Remove a job
  # ------------

  elif [ $num -eq 4 ]
	then

		#prompt for command to delete
		read -p "Enter the name of the command to be deleted: " commandDel

		#remove the command and update crontab file
		sed -i "/$commandDel/d" cronCopy;
		crontab cronCopy;
		echo "Job deleted successfully."

  # ---------------
	# Remove all jobs
  # ---------------

	elif [ $num -eq 5 ]
	then
    crontab -r >/dev/null 2>&1;
    echo "All jobs removed"

  # -------------------
	# Exit the while loop
  # -------------------

	elif [ $num -eq 9 ]
	then
		break

  # ------------------------------
	# Error if command is not listed
  # ------------------------------

	else
		echo "Error: command number $num is not listed."

	fi

done

# -- END

# delete cronCopy file
rm cronCopy;

# Exit crontab
echo "Exit successfull!"
