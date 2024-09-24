#!/bin/bash

source ./utils.sh

clean_network_and_user() {
    echo -e "${BOLD}${BLUE}----------------------------------------------------------"
    echo -e "\nCleaning network and user data...\n"
    echo -e "----------------------------------------------------------${RESET}"

    # Clear recent files
    clear_recent_files() {
        echo -e "${BOLD}Clearing recent files list...${RESET}"
        rm -f ~/.local/share/recently-used.xbel
    }

    # Clear swap memory
    clear_swap_memory() {
        echo -e "${BOLD}Clearing swap...${RESET}"
        sudo swapoff -a && sudo swapon -a
    }

    # Clear network data
    clear_network_data() {
        echo -e "${BOLD}Clearing known hosts...${RESET}"
        rm -f ~/.ssh/known_hosts
        echo -e "${BOLD}Clearing NetworkManager profiles...${RESET}"
        sudo rm -rf /etc/NetworkManager/system-connections/
    }

    # Clear user logs
    clear_user_logs() {
        echo -e "${BOLD}Clearing user-specific cache...${RESET}"
        rm -rf ~/.cache/
        echo -e "${BOLD}Clearing user-specific local share...${RESET}"
        rm -rf ~/.local/share/
    }

    # Clear clipboard history
    clear_clipboard_history() {
        echo -e "${BOLD}Clearing clipboard history...${RESET}\n"
        if command -v xclip &> /dev/null; then
            xclip -i /dev/null
        fi
        if command -v xsel &> /dev/null; then
            xsel -bc
        fi
    }

    # Call the functions
    clear_recent_files
    clear_swap_memory
    clear_network_data
    clear_user_logs
    clear_clipboard_history
}