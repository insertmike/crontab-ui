#!/bin/bash

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
      #pipeline cronCopy content to "read" command
			cat cronCopy | while read min hour day month weekDay cm
			do
        #counter increment
			  count=$((count + 1))

        #check for presence of "@" commands & print line
        if (echo "$min" | grep -Eq '@'); then

          #locate "@" line & assign to variable "$p"
          p=$(cat cronCopy | sed -n "$count"p);

          #read in variable "$p" & break into components
          read preset pre_setcommand <<< "$p"

          #print
          echo "Command No "$count": "$pre_setcommand""
          echo "Running "$preset""
          echo ""

        #all other commands, format output line accordingly:
        else
  				min=$(format_output_field "$min")
  				hour=$(format_output_field "$hour")
  				day=$(format_output_field "$day")
  				month=$(format_output_field "$month")
  				weekDay=$(format_output_field "$weekDay")

          #print output
  				echo "Command No "$count": "$cm""
          echo "Running: on "$min" minute/s, "$hour" hour/s, on "$day" day(s) of month, on "$month" month(s), "$weekDay" day(s) of the week"
          echo ""
        fi

			done

      #success
			return 1
		else

      #error
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
	else
		echo "every $1"
	fi
}

# ------------------
# [Ensure Range Function]
# --
# -- Context: Ensures that numeric $1 argument is in range between arguments $2 and $3
# --          Ensures values are according to the crontab specification
# --          - Lists: "4-8,6-20"..."6,4,6,7"
# --          - Ranges: "4-6","6-7"..."0-23"
# --          - Steps:  "*/2","0-23/4"..."*/2,*/5"
# --          OR comabination of the 3 ie: "*/2,*/3,2,3,4,8-12"
# --
# -- Args: -> $1 ( User Argument )
# --       -> $2 ( Range: Lower Bound )
# --       -> $3 ( Range: Upper Bound )
# --
# -- Returns: -> 1 ( True ) | 0 ( False )
# --
# ------------------
ensure_range() {

  #start error log file with 0 (no errors)
  echo "0" >> error

  #split input values using (,) as delimiters
  #store split values in array
  IFS=',' read -r -a array <<< "$1"

  #iterate over array & validate split values indiviadually
  for element in "${array[@]}"
  do

    #check for input matchting patterns
    if (echo "$element" | grep -Eq '^([0-9]+-[0-9]+|\*)/[0-9]+$|^[0-9]+-[0-9]+$|^[0-9]+$')
    then

      #value range check
      #split all digits in string into subsequent substrings
      s=$(grep -Eo '[[:alpha:]]+|[0-9]+' <<< "$element")
      #iterate over the split digits & validate them indiviadually
      echo "$s" | while read -r line;
        do

          #digit value range check
        	if [ "$line" -ge "$2" ] && [ "$line" -le "$3" ]
        	then
        		#success
            continue
        	else
        		#error
            echo "***** Error: Invalid input, please check regulations and try again *****"
            #record error in log file
            echo "1" >> error
        	fi

        done
        continue

    #check only month name inputs:
    elif (echo "$element" | grep -Eq '(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)') && [ "$3" -eq 12 ]
    then
      continue

    #check only week day name inputs:
    elif (echo "$element" | grep -Eq '(Mon|Tue|Wed|Thu|Fri|Sat|Sun)') && [ "$3" -eq 6 ]
    then
      continue

    #otherwise error
    else
      echo "***** Error: Invalid input, please check regulations and try again *****"
      return 0

    fi

  done

  #read last line of error log file
  k=$(tail -n 1 error)

  #check for errors ie: 1
  if (echo "$k" | grep -Eq "1");
  then
    # error
    return 0
  else
    # success
    return 1
  fi

}

# ------------------
# [Ensure Pre-set Command Function]
# --
# -- Context: Prompts user to insert new crontab job
# --          from the pre-set commands list in crontab
# --
# -- If cron does not exist, it creates it
# -- Returns: -> 1 ( Success ) | 0 ( Failure )
# --

insert_crontab_job_pre_set() {

# -------------------------------------
#    Display pre-set commands menu
# -------------------------------------

	echo "----------------------"
	echo "Please select from the list of pre-set commands below:"
  echo ""
	echo "@reboot - Run once, at startup"
	echo "@yearly or @annualy - Run once a year"
  echo "@monthly - Run once a month"
	echo "@weekly - Run once a week"
	echo "@daily or @midnight - Run once a day"
	echo "@hourly - Run once an hour"
	echo ""
  echo 'Enter pre-ser command to use (ie: @reboot)'; read preset;

  # validate user inputs:
  if (echo "$preset" | grep -Eq '(@reboot|@yearly|@annualy|@monthly|@weekly|@daily|@midnight|@hourly)')
  then
    # Prompt for command input
    echo 'Enter command to install'; read pre_setcommand;

    # Place the command in the crontab file:
    echo "$preset $pre_setcommand" >> cronCopy;

    # Update crontab file
    crontab cronCopy

    # Success
    return 1

  else
    echo "***** Error: Invalid parameters, please check regulations and try again *****"

    # Error
    return 0
  fi
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

	# Prompt for minutes input
	echo 'Enter minutes ( 0 - 59 ) | * for any'; read minutes
	validate_input_field "$minutes" "min"
	if [ ! $? -eq 1 ]
	then
		return 0
	fi

  # Prompt for hours input
	echo 'Enter hour ( 0 - 23 ) | * for any:'; read hour
	validate_input_field "$hour" "hour"
	if [ ! $? -eq 1 ]
	then
		return 0
	fi

  # Prompt for day of month input
	echo 'Enter the day of month ( 1 - 31 ) | * for any:'; read day
	validate_input_field "$day" "day"
	if [ ! $? -eq 1 ]
	then
		return 0
	fi

  # Prompt for month input
	echo 'Enter month ( 1 - 12 ) | * for any:'; read month
	validate_input_field "$month" "month"
	if [ ! $? -eq 1 ]
	then
		return 0
	fi

  # Prompt for weekday input
	echo 'Enter weekday ( 0 - Sun, 6 - Sat ) | * for any:'; read weekDay
	validate_input_field "$weekDay" "weekDay"
	if [ ! $? -eq 1 ]
	then
		return 0
	fi

  # Prompt for task command input
  echo 'Enter command to install'; read user_command

	# Using quotes to catch the asterixes '*'
	echo "$minutes $hour $day $month $weekDay $user_command" >> cronCopy;

	# Update crontab file
	crontab cronCopy

  # Success
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

# -------------------------------------
# Base Case (*) - Valid for all inputs
# -------------------------------------
	if [ "$1" = "*" ];
	then
		return 1
	fi

  #using case
	case "$2" in

# -------------------------------------
#             Minute Case
# -------------------------------------
	"min")
		ensure_range "$1" 0 59
		return	$?
	  ;;

# -------------------------------------
#             Hour Case
# -------------------------------------
	"hour")
		ensure_range "$1" 0 23
		return	$?
	  ;;

# -------------------------------------
#             Day of Month Case
# -------------------------------------
	"day")
    ensure_range "$1" 1 31
		return	$?
	  ;;

# -------------------------------------
#             Month Case
# -------------------------------------
	"month")
    ensure_range "$1" 1 12
		return	$?
	  ;;

# -------------------------------------
#            WeekDay Case
# -------------------------------------
	"weekDay")
    ensure_range "$1" 0 6
		return	$?
	  ;;

# -------------------------------------
#   Default case: invalid parameters
# -------------------------------------
	*)
		echo "***** Error: Invalid parameters, please check regulations and try again *****"
		return 0
	  ;;

	esac
}

# - FUNCTION END

# -------------------------------------
# Crontab main menu command redirecting
# -------------------------------------

while true
  do

# -------------------------------------
#          Display the menu
# -------------------------------------

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
  #read in user input
	read -p "Select a command number: " num
	echo ""

# -------------------------------------
# User menu selection input validation
# -------------------------------------

  #pass user input to vaidation function
	ensure_range "$num" 1 9

  #check for errors (return status)
	if [ ! $? -eq 1 ]
	then
		continue
	fi

# -------------------------------------
#         Display all jobs (1)
# -------------------------------------

	if [ "$num" -eq 1 ]
	then
    #call function to print crontab jobs
		print_crontab_jobs

    #check for errors (return status)
		if [ ! $? -eq 1 ]
		then
			echo "No Jobs to Display"
		fi
		continue

# -------------------------------------
#         Insert a job (2)
# -------------------------------------

	elif [ "$num" -eq 2 ]
  then

    #prompt user for custom or pre-set schdeule commands
    echo 'Would you like to schedule a custom time or choose a pre-set time (ie: weekly)?';
    echo 'Please type: (1) for custom or (2) for pre-set'; read ans;

    if [ "$ans" -eq 1 ]
    then
      #call insert job function (custom time selection)
    	insert_crontab_job

    elif [ "$ans" -eq 2 ]
    then
      #call insert job function (Pre-set schedule time)
    	insert_crontab_job_pre_set

    else
      #error, invalid command selection
      echo "---- Incorrect command selection ----"
      continue
    fi

    #check for errors
  	if [ ! $? -eq 1 ]
  	then
  		continue
  	else
      echo ""
	  	echo "Job inserted"
  	fi
  	continue

# -------------------------------------
#           Edit a job (3)
# -------------------------------------

  elif [ "$num" -eq 3 ]
  then
    #call function to print crontab jobs
    print_crontab_jobs

    #check for errors
    if [ ! $? -eq 1 ]
    then
      echo "*** Job list is empty ***"
    	continue
    fi

    #prompt for command number to edit
    read -p "Select command number to be edited: " commandEdit

    #remove the command and update crontab file
    sed -i "$commandEdit"d cronCopy
    crontab cronCopy

    #prompt user for custom or pre-set schdeule commands
    echo ""
    echo 'Would you like to schedule a custom time or choose a pre-set time ie: weekly?';
    echo 'Please type: (1) for custom or (2) for pre-set'; read ans;

    if [ "$ans" -eq 1 ]
    then
      #call insert job function (custom time selection)
    	insert_crontab_job

    elif [ "$ans" -eq 2 ]
    then
      #call insert job function (Pre-set schedule time)
    	insert_crontab_job_pre_set

    else
      #error, invalid command selection
      echo "---- Incorrect command selection ----"
      continue
    fi

    #check for errors
    if [ ! $? -eq 1 ]
    then
      continue
    else
      echo "Job successfully edited"
      echo ""
    fi

    continue

# -------------------------------------
#           Remove a job (4)
# -------------------------------------

  elif [ "$num" -eq 4 ]
	then

    #instanciate counter
    count=0

    #call function to print crontab jobs
    print_crontab_jobs

    #check for errors
    if [ ! $? -eq 1 ]
    then
      echo "*** Job list is empty ***"
      echo ""
      continue
    fi

    #prompt for command number to delete
    read -p "Select command to be deleted: " commandDel

    #remove the command and update crontab file
    sed -i "$commandDel"d cronCopy;
    crontab cronCopy;

    echo "Job deleted successfully."
    echo ""
    continue

# -------------------------------------
#          Remove all jobs (5)
# -------------------------------------

	elif [ "$num" -eq 5 ]
	then

    #remove all crontab jobs
    crontab -r >/dev/null 2>&1;

    echo "All jobs removed"
    echo ""
    continue

# -------------------------------------
#        Exit the while loop (9)
# -------------------------------------

	elif [ "$num" -eq 9 ]
	then
		break

# -------------------------------------
#   Error if command is not listed
# -------------------------------------

	else
    echo "Error: command number $num is not listed."
    echo ""
    continue
	fi

done

# -- END

# delete cronCopy file
rm "cronCopy"

#  delete error file
rm "error"

# Exit crontab
echo "Exit successfull!"
