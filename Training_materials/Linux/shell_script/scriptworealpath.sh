#!/bin/bash

# If realpath command doesn’t work on the system then use this script
# The script takes an optional parameter [—test] and a parameter which tells the directory path [ROO_DIRECTORY] and pattern [PATTERN]to match files in the given directory. 
# Multiple patterns can be given like *.py, *.sh etc.,
# When —test option is specified, the script looks for files matching the pattern in specified directory recursively and prints the files onto the terminal
# when —test is not specified the script looks for files matching the pattern in specified directory recursively and deletes the files but before deleting it prompts the user about the deletion

#Author: Niroop Reddy 

#Usage: dirclean [--test] ROOT_DIRECTORY PATTERN...

#function to print the usage if something is wrong with the usage
usage () {
        echo " Usage dirclean [--test] ROOT_DIRECTORY PATTERN... "
        exit 1		#Exit the script once the above command is printed on to the terminal
}

#checking if number arguments are correct.
if [ $# -lt 2 ]; then
	usage
fi

#storing the command line arguments into an array "args"
args=("$@")		#Store the command line arguments to an array except the script name
cmd=$(which $0)		# “which” command is used to find the location of the script

#Checking if first argument is --test and do the operation accordingly.
#If it's true then it prints the file that needs to be deleted recursively
#else it prints the files and deletes them recursively
case ${args[0]} in
	--test)
		if [ ${#args[@]} -lt 3 ]; then
			usage
		fi

		pattern=("${args[@]:2:$#}")		#stores the values from array from index number 2 to last index value in pattern variable

		for file in “${args[1]}”/*; do
			if [[ -f "$file" ]]; then
				base=`base name $file`		#commands are generally specified in back ticks to get them executed; basename strips filename from its directory
				for i in "${pattern[@]}"; do
					if [[ "$base” == $i ]]; then
						echo "Deleting File : $file"
					fi
				done
			elif [[ -d "$file" ]]; then
				"$cmd" "--test" "$file" "$pattern"
			fi			
		done
		;;
	*)
		pattern=("${args[@]:1:$#}")		#stores the values from array from index number 1 to last index value in pattern variable
		
		for file in “${args[1]}“/*; do
			if [[ -f "$file" ]]; then
				base=`basename $file`
				for i in "${pattern[@]}"; do
					if [[ "$base” == $i ]]; then
						echo "Delete File : $file"
						rm -vi $file
					fi
				done
			elif [[ -d "$file" ]]; then
				"$cmd" "$file" "$pattern"
			fi			
		done		
		;;
esac
