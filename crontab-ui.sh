#!/bin/sh

touch cronCopy
chmod 777 cronCopy

# ------------------
# [Format Output Field Function]
# --
# -- Context: Helper function to output user friendly format of a field parameter from a crontab job
# --
# -- Args: -> $1 ( Output Field ) 
# --
# -- Returns: -> "any" if $1 equals "*", otherwise "every $1"
# --
# ------------------
format_output_field() {
	if [ "$1" = "*" ];then
		echo "any"
	else
		echo "every $1"
	fi
}


# ------------------
# [Validate Input Field Function]
# --
# -- Context: Validates whether user input is valid according to the corresponding field
# --
# -- Args: -> $1 ( User Input ) 
#	   -> $2 ( Field ) of { 'min', 'hour', 'day', 'month', 'weekDay' }
# --
# -- Returns -> 1 ( True )  | 0 ( False ) 
# --
# ------------------
validate_input_field() {
  	# ------------------------
	# [ Base Case - Asterix ] - Valid for all inputs
        # ------------------------
	if [ "$1" = "*" ];
	then
		echo "Debugging: Success"
		return
	fi

	case "$2" in

	# ------------------------
	# [ Minute Case ]
        # ------------------------
	"min")
		# Digit check
		# Any non-numberic values will result in error, which will be implicitly considered as false in shell
		if [ "$1" -eq "$1" ] 2>/dev/null; then
			# Range check
			if [ "$1" -ge "0" ] && [ "$1" -le "59" ]
			then
				echo "Debugging: Success"
				return 1
			else
				# Input out of range
				echo "Invalid range"
				return 0
			fi
		# Non digit -> Invalid
		else
			echo "Invalid input, please check regulations and try again"
			return 0
		fi
	  ;;
	# ------------------------
	# [ Hour Case ]
        # ------------------------
	"hour")
		# Digit check
		# Any non-numberic values will result in error, which will be implicitly considered as false in shell
		if [ "$1" -eq "$1" ] 2>/dev/null; then
			# Range check
			if [ "$1" -ge "0" ] && [ "$1" -le "23" ]
			then
				echo "Debugging: Success"
				return 1
			else
				# Input out of range
				echo "Invalid range"
				return 0
			fi
		# Non digit -> Invalid
		else
			echo "Invalid input, please check regulations and try again"
			return 0
		fi
	;;
	# ------------------------
	# [ Day Case ]
        # ------------------------
	"day")
		# Digit check
		# Any non-numberic values will result in error, which will be implicitly considered as false in shell
		if [ "$1" -eq "$1" ] 2>/dev/null; then
			# Range check
			if [ "$1" -ge "1" ] && [ "$1" -le "31" ]
			then
				echo "Debugging: Success"
				return 1
			else
				# Input out of range
				echo "Invalid range"
				return 0
			fi
		# Non digit -> Invalid
		else
			echo "Invalid input, please check regulations and try again"
			return 0
		fi
	  ;;
	  
	# ------------------------
	# [ Month Case ]
        # ------------------------
	"month")
		# Digit check
		# Any non-numberic values will result in error, which will be implicitly considered as false in shell
		if [ "$1" -eq "$1" ] 2>/dev/null; then
			# Range check
			if [ "$1" -ge "1" ] && [ "$1" -le "12" ]
			then
				echo "Debugging: Success"
				return 1
			else
				# Input out of range
				echo "Invalid range"
				return 0
			fi
		# Non digit -> Invalid
		else
			echo "Invalid input, please check regulations and try again"
			return 0
		fi
	  ;;
	# ------------------------
	# [ WeekDay Case ]
        # ------------------------
	"weekDay")
		# Digit check
		# Any non-numberic values will result in error, which will be implicitly considered as false in shell
		if [ "$1" -eq "$1" ] 2>/dev/null; then
			# Range check
			if [ "$1" -ge "0" ] && [ "$1" -le "6" ]
			then
				echo "Debugging: Success"
				return 1
			else
				# Input out of range
				echo "Invalid range"
				return 0
			fi
		# Non digit -> Invalid
		else
			echo "Invalid input, please check regulations and try again"
			return 0
		fi
	  ;;
	# ------------------------
	# [ Default case: invalid parameters
        # ------------------------
	*)
		echo "Debugging: Invalid parameters"
		return 0
	  ;;
	esac
}


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
				min=$(format_output_field "$min")
				hour=$(format_output_field "$hour")
				day=$(format_output_field "$day")
				month=$(format_output_field "$month")
				weekDay=$(format_output_field "$weekDay")
	
				printf "Command: %s. Running: on %s minute, %s hours, on %s day of month,  on %s month, %s day of the week\n" "$cm" "$min" "$hour" "$day" "$month" "$weekDay"
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
	validate_input_field "$minutes" "min" 
	if [ $? -eq 0 ]
	then
		continue
	fi
  	echo 'Enter hour ( 0 - 23 ) | * for any:'; read hour
	validate_input_field "$hour" "hour"
	if [ $? -eq 1 ]
	then
		continue
	fi
  	echo 'Enter the day ( 1 - 31 ) | * for any:'; read day
	validate_input_field "$day" "day"
	if [ $? -eq 1 ]
	then
		continue
	fi
  	echo 'Enter day of month ( 1 - 12 ) | * for any:'; read month
	validate_input_field "$month" "month"
	if [ $? -eq 1 ]
	then
		continue
	fi
  	echo 'Enter weekday ( 0 - Sun, 6 - Sat ) | * for any:'; read weekDay
	validate_input_field "$weekDay" "weekDay"
	if [ $? -eq 1 ]
	then
		continue
	fi
  	echo 'Enter command to install'; read user_command

  	# Using quotes to catch the asterixes '*'
  	echo "$minutes $hour $day $month $weekDay $user_command" >> cronCopy;

  	# Update crontab file
  	crontab cronCopy
  	echo "Job inserted"
    echo ""

  # ----------
	# Edit a job
  # ----------

	elif [ $num -eq 3 ]
	then

  #instanciate counter
  count=0

  #show the user the available commands
  while read line;
  do
    count=$((count + 1))
    echo "$count"." $line"
    echo ""

  #read-in filename cronCopy
  done < cronCopy

  #prompt for command to edit
  read -p "Select command to be edited: " commandEdit

  #remove the command and update crontab file
  sed -i "$commandEdit"d cronCopy
  crontab cronCopy

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
  echo ""

  # ------------
	# Remove a job
  # ------------

  elif [ $num -eq 4 ]
	then

  #instanciate counter
  count=0

  #show the user the available commands
  while read line;
  do
    count=$((count + 1))
    echo "$count"." $line"
    echo ""

  #read-in filename cronCopy
  done < cronCopy

  #prompt for command to delete
  read -p "Select command to be deleted: " commandDel

  #remove the command and update crontab file
  sed -i "$commandDel"d cronCopy;
  crontab cronCopy;
  echo "Job deleted successfully."
  echo ""

  # ---------------
	# Remove all jobs
  # ---------------

	elif [ $num -eq 5 ]
	then
    crontab -r >/dev/null 2>&1;
    echo "All jobs removed"
    echo ""

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
    echo ""

	fi

done

# -- END

# delete cronCopy file
rm cronCopy;

# Exit crontab
echo "Exit successfull!"

