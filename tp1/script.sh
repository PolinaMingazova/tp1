#!/bin/bash

input_dir="$1" 
output_dir="$2"

readarray -t files < <(find "$input_dir" -type f)

for file in "${files[@]}"; do
	if [ -f "$file" ]; then
		filename=$(basename "$file")
		if [ -f "$output_dir/$filename" ]; then
			new_filename="$filename"
			counter=1
			while [ -f "$output_dir/$new_filename" ]; do
				new_filename="${filename%.*}_$counter.${filename##*.}"
				((counter++))
			done
			cp "$file" "$output_dir/$new_filename"
		else
			cp "$file" "$output_dir"
		fi
	fi
done
