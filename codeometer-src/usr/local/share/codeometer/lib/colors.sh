#!/bin/bash

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
RESET='\033[0m'

# Function to apply color if colors are enabled
apply_color() {
    if $USE_COLORS; then
        echo -ne "${!1}"
    fi
}

# Function to reset color if colors are enabled
reset_color() {
    if $USE_COLORS; then
        echo -ne "${RESET}"
    fi
}
