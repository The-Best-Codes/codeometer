#!/bin/bash

# Function to get terminal width
get_terminal_width() {
    if $USE_FORMATTING; then
        tput cols 2>/dev/null || echo 80
    else
        echo 80
    fi
}

# Function to print centered text
print_centered() {
    if $USE_FORMATTING; then
        local text="$1"
        local width=$(get_terminal_width)
        local padding=$(((width - ${#text}) / 2))
        printf "%${padding}s%s%${padding}s\n" "" "$text" ""
    else
        echo "$1"
    fi
}

# Function to print a horizontal line
print_line() {
    if $USE_FORMATTING; then
        local width=$(get_terminal_width)
        printf '%*s\n' "$width" | tr ' ' '-'
    fi
}

# Function to display progress bar
display_progress() {
    if $USE_FORMATTING; then
        local current=$1
        local total=$2
        local width=$(($(get_terminal_width) - 20))
        local percentage=$((current * 100 / total))
        local filled=$((width * current / total))
        local empty=$((width - filled))

        apply_color "CYAN"
        printf "\rProgress: ["
        apply_color "GREEN"
        printf '%*s' "$filled" | tr ' ' '#'
        apply_color "CYAN"
        printf '%*s' "$empty" | tr ' ' '-'
        printf "] %3d%%" "$percentage"
        reset_color
    fi
}
