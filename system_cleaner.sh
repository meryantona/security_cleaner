#!/bin/bash

source ./utils.sh

clean_system() {
    echo -e "${BOLD}${BLUE}----------------------------------------------------------"
    echo -e "\nCleaning system data...\n"
    echo -e "----------------------------------------------------------${RESET}"


    # Clear system logs
    clear_system_logs() {
        echo -e "${BOLD}Clearing syslog...${RESET}"
        sudo truncate -s 0 /var/log/syslog
        echo -e "${BOLD}Clearing auth log...${RESET}"
        sudo truncate -s 0 /var/log/auth.log
    }

    # Clear temporary files
    clear_temp_files() {
        echo -e "${BOLD}Clearing /tmp files...${RESET}"
        sudo rm -rf /tmp/*
        echo -e "${BOLD}Clearing /var/tmp files...${RESET}"
        sudo rm -rf /var/tmp/*
    }

    # Clear systemd logs
    clear_systemd_logs() {
        echo -e "${BOLD}Clearing systemd journal logs...${RESET}\n"
        sudo journalctl --vacuum-time=1s
    }

    # Call the functions
    clear_system_logs
    clear_temp_files
    clear_systemd_logs
}