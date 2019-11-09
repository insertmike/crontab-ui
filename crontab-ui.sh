#!/bin/sh

touch cronCopy
chmod 777 cronCopy

# ------------------
# [Print Cronrab Jobs Function]
# --
# -- Context: Prints current crontab jobs in User Friendly Way
# --
# ------------------
print_crontab_jobs() {

    #update cronCopy with content of crontab
    crontab -l > cronCopy 2>/dev/null;

    #checks for content in cronCopy
		if [ -s cronCopy ]
		then
			#instanciate counter
			count=0
			cat cronCopy | while read min hour day month weekDay cm
			do
			  count=$((count + 1))

        # Checking for preset commands:
        if (echo "$min" | grep -Eq '@'); then
          printf "Command No %s: %s Running: %s \n" "$count" "$min" "$hour $day $month $WeekDay $cm";
        # All other commands:
        else
  				min=$(format_output_field "$min")
  				hour=$(format_output_field "$hour")
  				day=$(format_output_field "$day")
  				month=$(format_output_field "$month")
  				weekDay=$(format_output_field "$weekDay")

  				printf "Command No %s: %s Running: on %s minute/s, %s hour/s, on %s day(s) of month,  on %s month(s), %s day(s) of the week\n" "$count" "$cm" "$min" "$hour" "$day" "$month" "$weekDay"
  				echo ""
        fi
			done
			return 1
		else
			return 0
		fi
}

# ------------------
# [Format Output Field Function]
# --
# -- Context: Helper function to output user friendly format of a field parameter from a crontab job
# --
# -- Args: -> $1 ( Output Field )
# --
# -- Returns: -> "any" if $1 equals "*",
# --             "between" {range}, every other {value} STEPs
# --             otherwise "every $1"
# --
# ------------------
format_output_field() {

	if [ "$1" = "*" ];then
		echo "any";

  # Handling STEP value Output Format
  elif (echo "$1" | grep -Eq '(/)'); then
    if (echo "$1" | grep -Eq '(\*)'); then
      (echo -n "every other "); (echo -n "$1" | grep -o -E '[^/]*$' | tr '\n' ' ');
    else
      echo -n "between "; (echo -n "$1" | grep -o -E '^[^/]*' | tr '\n' ' '); (echo -n "every other "); (echo -n "$1" | grep -o -E '[^/]*$' | tr '\n' ' ');
    fi

  # Handling RANGES & LISTS value Output Format
  elif (echo "$1" | grep -Eq '(-|,)'); then
    echo -n "between $1";

	else
		echo "every $1"
	fi
}

# ------------------
# [ Ensure Numeric Argument Function]
# --
# -- Context: Checks if argument is a numeric value
# --
# -- Args: -> $1 ( Argument To Be Checked )
# --
# -- Returns: -> 1 ( True ) | 0 ( False )
# --
# ------------------
ensure_numeric() {
	if [ "$1" -eq "$1" ] 2>/dev/null; then
		return 1
	else
		return 0
	fi
}

# ------------------
# [Ensure Range Function]
# --
# -- Context: Ensures that numeric $1 argument is in range between arguments $2 and $3
# --
# -- Args: -> $1 ( User Argument )
#          -> $2 ( Range: Lower Bound )
#          -> $3 ( Range: Upper Bound )
# --
# -- Returns: -> 1 ( True ) | 0 ( False )
# --
# ------------------
ensure_range() {

  # Check for STEPs, LISTS & RANGES (check coursework doc) values of the form (0-23|*) / (0-23)
  if (echo "$1" | grep -Eq '(,?([0-9]+-[0-9]+|\*)/[0-9]+)$|(,?[0-9]+-[0-9]+)$|(,?[0-9]+)$')
  then
		# Success
		return 1
  else

    # Otherwise, continue validation:

  	# Check -> Numeric value
  	ensure_numeric "$1"
  	if [ ! $? -eq 1 ]
  	then
  		echo "***** Error: Invalid input, please check regulations and try again *****"
  		return 0
  	fi

  	# Range check
  	if [ "$1" -ge "$2" ] && [ "$1" -le "$3" ]
  	then
  		# Success
  		return 1
  	else
  		# Failure -> Input out of range
  		echo "***** Error: Invalid range, please check regulations and try again *****"
  		return 0
  	fi

  fi
}

# ------------------
# [Ensure Pre-set Command Function]
# --
# -- Context: Ensures that numeric $1 argument is in range between arguments $2 and $3
# --
# -- Args: -> $1 ( User Argument )
#          -> $2 ( Range: Lower Bound )
#          -> $3 ( Range: Upper Bound )
# --
# -- Returns: -> 1 ( True ) | 0 ( False )
# --

insert_crontab_job_pre_set() {

  # ------------------
  # [Display pre-set commands menu]
  # ------------------

	echo "----------------------"
	echo "Please select from the list of pre-set commands below:"
  echo "--"
	echo "@reboot - Run once, at startup"
	echo "@yearly or @annualy - Run once a year"
  echo "@monthly - Run once a month"
	echo "@weekly - Run once a week"
	echo "@daily or @midnight- Run once a day"
	echo "@hourly - Run once an hour"
	echo ""
  echo 'Enter pre-ser command to use (ie: @reboot)'; read preset;
	echo ""
  echo 'Enter command to install'; read pre_setcommand;

  # Place the command in the crontab file:
  echo "$preset $pre_setcommand" >> cronCopy;

  # Update crontab file
  crontab cronCopy
return 1

}

# ------------------
# [Insert Crontab Job]
# --
# -- Context: Prompts user to insert new crontab job
# -- If cron does not exist, it creates it
# -- Returns: -> 1 ( Success ) | 0 ( Failure )
# --
# ------------------
insert_crontab_job() {

  	# Prompt for command settings input
  	echo 'Enter minutes ( 0 - 59 ) | * for any'; read minutes
	validate_input_field "$minutes" "min"
	if [ ! $? -eq 1 ]
	then
		return 0
	fi
  	echo 'Enter hour ( 0 - 23 ) | * for any:'; read hour
	validate_input_field "$hour" "hour"
	if [ ! $? -eq 1 ]
	then
		return 0
	fi
  	echo 'Enter the day ( 1 - 31 ) | * for any:'; read day
	validate_input_field "$day" "day"
	if [ ! $? -eq 1 ]
	then
		return 0
	fi
  	echo 'Enter day of month ( 1 - 12 ) | * for any:'; read month
	validate_input_field "$month" "month"
	if [ ! $? -eq 1 ]
	then
		return 0
	fi
  	echo 'Enter weekday ( 0 - Sun, 6 - Sat ) | * for any:'; read weekDay
	validate_input_field "$weekDay" "weekDay"
	if [ ! $? -eq 1 ]
	then
		return 0
	fi
  	echo 'Enter command to install'; read user_command

  	# Using quotes to catch the asterixes '*'
  	echo "$minutes $hour $day $month $weekDay $user_command" >> cronCopy;

  	# Update crontab file
  	crontab cronCopy
	return 1
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
		return 1
	fi

	case "$2" in

	# ------------------------
	# [ Minute Case ]
  # ------------------------
	"min")
		ensure_range "$1" 0 59
		return	$?

	  ;;
	# ------------------------
	# [ Hour Case ]
  # ------------------------
	"hour")
		ensure_range "$1" 0 23
		return	$?
	 ;;
	# ------------------------
	# [ Day Case ]
  # ------------------------
	"day")
    ensure_range "$1" 1 31
		return	$?
	;;

	# ------------------------
	# [ Month Case ]
  # ------------------------
	"month")
    # check for string months inputs:
    if (echo "$1" | grep -Eq '(,?Jan,?|,?Feb,?|,?Mar,?|,?Apr,?|,?May,?|,?Jun,?|,?Jul,?|,?Aug,?|,?Sep,?|,?Oct,?|,?Nov,?|,?Dec,?)')
    then
      # Success
      return 1
    else
		    ensure_range "$1" 1 12
    fi
		return	$?
	  ;;
	# ------------------------
	# [ WeekDay Case ]
  # ------------------------
	"weekDay")
    # check for string weekdays inputs:
    if (echo "$1" | grep -Eq '(,?Mon,?|,?Tue,?|,?Wed,?|,?Thu,?|,?Fri,?|,?Sat,?|,?Sun,?)')
    then
      # Success
      return 1
    else
		    ensure_range "$1" 0 6
    fi
		return	$?
	  ;;
	# ------------------------
	# [ Default case: invalid parameters
  # ------------------------
	*)
		echo "***** Error: Invalid parameters, please check regulations and try again *****"
		return 0
	  ;;
	esac
}


while true
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

	ensure_range "$num" 1 9
	if [ ! $? -eq 1 ]
	then
		continue
	fi

  # ------------------------
  # [Menu commands handling]
  # ------------------------

  # -----------------
	# Display all jobs
  # -----------------

	if [ "$num" -eq 1 ]
	then
		print_crontab_jobs
		if [ ! $? -eq 1 ]
		then
			echo "No Jobs to Display"
		fi
		continue

  # ------------
	# Insert a job
  # ------------

	elif [ "$num" -eq 2 ]
  then
    # Prompt user input for simple commands ie: @reboot, @annually
    echo 'Would you like to schedule a custom time or choose a pre-set time ie: weekly?';
    echo 'Please type: (1) -for "custom" or (2) - for "pre-set"'; read ans;

    if [ "$ans" -eq 1 ]
    then
      # Insert Job Method (Custom time selection)
    	insert_crontab_job

    elif [ "$ans" -eq 2 ]
    then
      # Insert Job Method (Custom time pre-set)
    	insert_crontab_job_pre_set

    else
      echo "---- Incorrect command selection ----"
      continue
    fi
  	if [ ! $? -eq 1 ]
  	then
  		continue
  	else
      echo ""
	  	echo "Job inserted"
  	fi
  	continue

  # ----------
	# Edit a job
  # ----------

  elif [ "$num" -eq 3 ]
  then
	   # Print current crontab jobs
     print_crontab_jobs

     # Method Error Handling
     if [ ! $? -eq 1 ]
     then
	      echo "*** Job list is empty ***"
    		continue
  	 fi

   #prompt for command to edit
   read -p "Select command to be edited: " commandEdit

   #remove the command and update crontab file
   sed -i "$commandEdit"d cronCopy
   crontab cronCopy

	 # Insert new job
	 insert_crontab_job
	 if [ ! $? -eq 1 ]
	 then
		  continue
	 else
	    echo "Job successfully edited"
	 fi
	 continue

  # ------------
	# Remove a job
  # ------------

  elif [ "$num" -eq 4 ]
	then

  #instanciate counter
  count=0

  print_crontab_jobs
  if [ ! $? -eq 1 ]
  then
	   echo "*** Job list is empty ***"
     continue
  fi
  #prompt for command to delete
  read -p "Select command to be deleted: " commandDel

  #remove the command and update crontab file
  sed -i "$commandDel"d cronCopy;
  crontab cronCopy;
  echo "Job deleted successfully."
  echo ""
  continue

  # ---------------
	# Remove all jobs
  # ---------------

	elif [ "$num" -eq 5 ]
	then
    crontab -r >/dev/null 2>&1;
    echo "All jobs removed"
    echo ""
    continue

  # -------------------
	# Exit the while loop
  # -------------------

	elif [ "$num" -eq 9 ]
	then
		break

  # ------------------------------
	# Error if command is not listed
  # ------------------------------

	else
		echo "Error: command number $num is not listed."
    echo ""
    continue
	fi

done

# -- END

# delete cronCopy file
rm cronCopy;

# Exit crontab
echo "Exit successfull!"
