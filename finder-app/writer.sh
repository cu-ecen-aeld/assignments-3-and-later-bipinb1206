#!/bin/bash

# Check if the required arguments are specified
if [ $# -ne 2 ]; then
  echo "Usage: writer.sh <writefile> <writestr>"
  exit 1
fi

# Get the path to the writefile file
writefile="$1"

# Get the write string
writestr="$2"

# Create the directory containing the writefile file, if it doesn't exist
mkdir -p "$(dirname "$writefile")"

# Create the writefile file, overwriting any existing file
echo "$writestr" > "$writefile"

# Check if the file was created successfully
if [ ! -f "$writefile" ]; then
  echo "Error: Could not create file $writefile"
  exit 1
fi

# Success!
#echo "File $writefile was created successfully"

