#!/bin/bash

# create 2 variables that store folders
input_dir="$1" 
output_dir="$2"

# create a list of all files stored in a folder "input_dir"
files=()
while IFS= read -r -d '' file; do
	files+=("$file")
done < <(find "$input_dir" -type f -print0)

# in the loop take each file from the list
for file in "${files[@]}"; do
	# create a variable that stores only the file name without the path to it
	filename=$(basename "$file")
 	# check if there is a file with that name in the folder "output_dir"
  	#if there is, look for which file with that name, rename it according to the number and add it, if not, add the file without changing its name
	if [[ -f "$output_dir/$filename" ]]; then
		new_filename="$filename"
		counter=1
  		# files with the same name, except for the first one, are renamed in the form *original file name*_*name repeat number*
    		# the first file with this name leaves its name, the second becomes *original file name*_1 and so on
		while [[ -f "$output_dir/$new_filename" ]]; do
			new_filename="${filename%.*}_$counter.${filename##*.}"
			((counter++))
		done
		cp "$file" "$output_dir/$new_filename"
	else
		cp "$file" "$output_dir"
	fi
done
