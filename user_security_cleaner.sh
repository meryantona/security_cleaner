#!/bin/bash

source ./utils.sh

clean_security() {
    echo -e "${BOLD}${BLUE}----------------------------------------------------------"
    echo -e "\nCleaning security data...\n"
    echo -e "----------------------------------------------------------${RESET}"

    # Clear SSH keys
    clear_ssh_keys() {
        echo -e "${BOLD}Clearing SSH keys...${RESET}"
        rm -rf ~/.ssh/*
    }

    # Clear GPG keys
    clear_gpg_keys() {
        echo -e "${BOLD}Clearing GPG keys...${RESET}"
        rm -rf ~/.gnupg/*
    }

    # Clear saved passwords
    clear_saved_passwords() {
        echo -e "${BOLD}Clearing GNOME keyring data...${RESET}\n"
        rm -rf ~/.gnome2/keyrings/
    }

    # Clear KeePassXC Database Files
    clear_keepass_databases() {
        echo -e "\n${BOLD}${YELLOW}Searching for KeePassXC Databases (*.kdbx)${RESET}"
    
    # Find all .kdbx files, search in home directory
        mapfile -t db_files < <(find ~ -type f -name "*.kdbx" 2>/dev/null)

        if [ ${#db_files[@]} -eq 0 ]; then
            echo -e "${YELLOW}No KeePassXC database files found.${RESET}"
            return
        fi

        echo -e "${CYAN}Found the following KeePassXC database files:${RESET}"

    # Enumerate and display the databases in human-readable format
        for i in "${!db_files[@]}"; do
            local size=$(du -sh "${db_files[$i]}" 2>/dev/null | cut -f1)
            echo -e "${BOLD}${CYAN}[$((i+1))]${RESET} ${db_files[$i]} (${size})"
        done

    # Ask user which file to delete
        read -p "${BOLD}${CYAN}Enter the number(s) of the database(s) you want to delete (e.g., 1 2 3), or press Enter to skip: ${RESET}" -a to_delete

        if [ -z "$to_delete" ]; then
            echo -e "${YELLOW}No database files selected for deletion. Skipping.${RESET}"
            return
        fi

    # Confirm the deletion of selected files
        read -p "${BOLD}${CYAN}Are you sure you want to delete the selected database(s)? (y/n) ${RESET}" confirm
        if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
            for num in "${to_delete[@]}"; do
                if [ "$num" -le "${#db_files[@]}" ] && [ "$num" -ge 1 ]; then
                    rm -f "${db_files[$((num-1))]}"
                    echo -e "${GREEN}Deleted: ${db_files[$((num-1))]}${RESET}"
                else
                    echo -e "${RED}Invalid selection: $num${RESET}"
                fi
            done
        else
            echo -e "${YELLOW}Skipping deletion of selected databases.${RESET}"
        fi
}

    # Call the functions
    clear_ssh_keys
    clear_gpg_keys
    clear_saved_passwords
    clear_keepass_databases
}