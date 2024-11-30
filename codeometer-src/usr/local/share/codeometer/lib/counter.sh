#!/bin/bash

# Function to count lines and files
count_lines_and_files() {
    find "$1" -type f \( -name "*.$2" \) -print0 | wc -l --files0-from=- 2>/dev/null | awk '
        NF==2 {files++; lines+=$1}
        END {print lines, files}'
}

# Function to count lines by extension
count_lines_by_extension() {
    local dir="$1"
    local ext="$2"
    local include_hidden=${3:-false}
    local exclude_pattern=""
    
    if ! $include_hidden; then
        exclude_pattern="-not -path '*/\.*'"
    fi
    
    find "$dir" -type f $exclude_pattern \( -name "*.$ext" \) -print0 | \
        wc -l --files0-from=- 2>/dev/null | \
        awk 'NF==2 {files++; lines+=$1} END {print lines, files}'
}

# Function to count comment lines
count_comment_lines() {
    local file="$1"
    local ext="$2"
    local comment_lines=0
    
    case $ext in
        py)
            comment_lines=$(grep -c "^[[:space:]]*#" "$file")
            ;;
        js|ts|jsx|tsx|java|cpp|c|h|hpp)
            comment_lines=$(grep -c "^\s*//" "$file")
            comment_lines=$((comment_lines + $(grep -c "^\s*/\*" "$file")))
            ;;
        rb)
            comment_lines=$(grep -c "^[[:space:]]*#" "$file")
            ;;
        *)
            comment_lines=0
            ;;
    esac
    
    echo "$comment_lines"
}
