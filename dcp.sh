#!/bin/bash

# Function to recursively list and copy file names and content
process_files() {
    for file in "$1"/*; do
        if [ -d "$file" ]; then
            echo "Directory: $file"
            process_files "$file"
        else
            echo "File: $file"
            echo "=== $file ===" >> /tmp/copy_buffer
            cat "$file" >> /tmp/copy_buffer
            echo -e "\n\n" >> /tmp/copy_buffer
        fi
    done
}

# Check if a directory is provided
if [ -z "$1" ]; then
    echo "Please provide a directory."
    exit 1
fi


# Clear the temporary buffer
> /tmp/copy_buffer

# Process the directory
process_files "$1"

# Copy the content to clipboard
cat /tmp/copy_buffer | pbcopy

echo "File names and content copied to clipboard!"
