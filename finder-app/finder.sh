#!/bin/bash

# Check if the required arguments are specified
if [ $# -ne 2 ]; then
  echo "Usage: finder.sh <filesdir> <searchstr>"
  exit 1
fi

# Check if filesdir represents a directory on the filesystem
if [ ! -d "$1" ]; then
  echo "Error: $1 is not a directory"
  exit 1
fi

# Get the path to the filesdir directory
filesdir="$1"

# Get the search string
searchstr="$2"

# Initialize the number of files and matching lines
num_files=0
num_lines=0

# Recursively traverse the filesdir directory and all subdirectories
function find_files() {
  local current_dir="$1"

  # Get the list of files and directories in the current directory
  local files_and_dirs=($(ls -A "$current_dir"))

  # Iterate over the list of files and directories
  for file_or_dir in "${files_and_dirs[@]}"; do

    # Check if the file or directory is a directory
    if [ -d "$current_dir/$file_or_dir" ]; then
      # Recursively traverse the directory
      find_files "$current_dir/$file_or_dir"
    else
      # Check if the file contains the search string
      if grep -q "$searchstr" "$current_dir/$file_or_dir"; then
        # Increment the number of matching lines
        num_lines=$((num_lines+1))
      fi

      # Increment the number of files
      num_files=$((num_files+1))
    fi
  done
}

# Find all files in the filesdir directory and all subdirectories
find_files "$filesdir"

# Print the message
echo "The number of files are $num_files and the number of matching lines are $num_lines"

