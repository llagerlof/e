#!/bin/bash

# This script opens the most recently modified text file in the current directory using available fallback editors.
#
# Usage: ./script.sh [-h] [number]
#   -h       Include hidden files
#   number   The order of the file to open (1 = newest)
#
# Version: 0.2.0

# Initialize variables
include_hidden=false
num=1

# Function to display usage
usage() {
    echo "Usage: $0 [-h] [number]"
    echo "  -h       Include hidden files"
    echo "  number   The order of the file to open (1 = newest)"
    exit 1
}

# Parse options
while getopts ":h" opt; do
  case $opt in
    h)
      include_hidden=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      usage
      ;;
  esac
done

# Shift arguments to access positional parameters correctly
shift $((OPTIND -1))

# Get the file number argument if provided
if [ -n "$1" ]; then
    if ! [[ "$1" =~ ^[1-9][0-9]*$ ]]; then
        echo "Error: Argument must be a positive integer."
        usage
    fi
    num="$1"
fi

# Initialize an array to hold text files
text_files=()

# Use find and sort to get files sorted by modification time (newest first)
if [ "$include_hidden" = true ]; then
    # Include hidden files
    mapfile -t files < <(find . -maxdepth 1 -type f \( ! -name '.' \) -printf '%T@ %p\n' | sort -nr)
else
    # Exclude hidden files
    mapfile -t files < <(find . -maxdepth 1 -type f ! -name '.*' -printf '%T@ %p\n' | sort -nr)
fi

# Iterate through the sorted files and collect text files
for line in "${files[@]}"; do
    # Extract the file path (second field)
    file="${line#* }"
    # Remove leading './' from the file path
    file="${file#./}"
    # Check if it's a regular file
    if [ -f "$file" ]; then
        # Check if the file is a text file using MIME type
        if file --mime-type "$file" | grep -q 'text/'; then
            text_files+=("$file")
        fi
    fi
done

# Check if there are any text files
if [ ${#text_files[@]} -eq 0 ]; then
    echo "No text files found in the current directory."
    exit 0
fi

# Validate the file number
if [ "$num" -le 0 ] || [ "$num" -gt "${#text_files[@]}" ]; then
    echo "Invalid file number. There are only ${#text_files[@]} text file(s)."
    exit 1
fi

# Select the file based on the provided number
selected_file="${text_files[$((num - 1))]}"

# Determine which editor to use
if command -v nvim >/dev/null 2>&1; then
    editor="nvim"
elif command -v vim >/dev/null 2>&1; then
    editor="vim"
elif command -v nano >/dev/null 2>&1; then
    editor="nano"
elif command -v vi >/dev/null 2>&1; then
    editor="vi"
elif command -v less >/dev/null 2>&1; then
    editor="less"
else
    echo "Error: None of the supported editors are installed (nvim, vim, nano, vi, less)."
    exit 1
fi

# Check write permission and open the file accordingly
if [ -w "$selected_file" ]; then
    "$editor" "$selected_file"
else
    sudo "$editor" "$selected_file"
fi

