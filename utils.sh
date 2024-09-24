#!/bin/bash

# Define colors
BOLD=$(tput bold)
YELLOW=$(tput setaf 013)
BLUE=$(tput setaf 004)
CYAN=$(tput setaf 006)
MAGENTA=$(tput setaf 005)
GREEN=$(tput setaf 002)
RED=$(tput setaf 001)
BLINK=$(tput blink)
RESET=$(tput sgr0) 

display_banner() {
    echo -e "${CYAN}"
    echo '███████╗███████╗ ██████╗██╗   ██╗██████╗ ██╗████████╗██╗   ██╗'
    echo '██╔════╝██╔════╝██╔════╝██║   ██║██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝'
    echo '███████╗█████╗  ██║     ██║   ██║██████╔╝██║   ██║    ╚████╔╝ '
    echo '╚════██║██╔══╝  ██║     ██║   ██║██╔══██╗██║   ██║     ╚██╔╝  '
    echo '███████║███████╗╚██████╗╚██████╔╝██║  ██║██║   ██║      ██║   '
    echo '╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝   ╚═╝      ╚═╝   '
    echo ' ██████╗██╗     ███████╗ █████╗ ███╗   ██╗███████╗██████╗     '
    echo '██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║██╔════╝██╔══██╗    '
    echo '██║     ██║     █████╗  ███████║██╔██╗ ██║█████╗  ██████╔╝    '
    echo '██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║██╔══╝  ██╔══██╗    '
    echo '╚██████╗███████╗███████╗██║  ██║██║ ╚████║███████╗██║  ██║    '
    echo ' ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝    '
    echo ' ----------------------------------------------------------   '
    echo ' A secure script for deleting data in your machine.           '
    echo ' Please, read what this does before running, you may loose important data. '
    echo ' '
    echo ' Run at your own risk.'
    echo ''
    echo ' Version 1.3 September 2024 // Made with ♥ by Mery Antona'
    echo -e "${RESET}"
}

# Function to convert bytes to human-readable format

human_readable() {
    local bytes=$1
    if ((bytes < 1024)); then
        echo "${bytes}B"
    elif ((bytes < 1048576)); then
        echo "$(( (bytes + 512) / 1024 ))KB"
    elif ((bytes < 1073741824)); then
        echo "$(( (bytes + 524288) / 1048576 ))MB"
    else
        echo "$(( (bytes + 536870912) / 1073741824 ))GB"
    fi
}

# Add any other utility functions here