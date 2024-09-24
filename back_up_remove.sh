#!/bin/bash

source ./utils.sh

# Clear backup files
clear_backup_files() {
    ##############################################
    # DEFINE YOUR BACKUP DIRECTORIES HERE
    # You can modify these to suit your needs
    ##############################################
    BACKUP_DIRS=("$HOME/backup" "$HOME/backups")

    # Define backup file patterns
    BACKUP_PATTERNS=("*.bak" "*.zip" "*.iso" "*.tar.gz")
    
    echo -e "${BOLD}${BLUE}----------------------------------------------------------"
    echo -e "\nSearching for backup directories and files...\n"
    echo -e "----------------------------------------------------------${RESET}"

    # Search for backup files in the defined directories
    for dir in "${BACKUP_DIRS[@]}"; do
        if [ -d "$dir" ]; then
            echo -e "${GREEN}Found directory: $dir${RESET}"
            FOUND_FILES=()
            TOTAL_SIZE=0
            
            for pattern in "${BACKUP_PATTERNS[@]}"; do
                while IFS= read -r file; do
                    if [ -f "$file" ]; then
                        size=$(du -b "$file" | cut -f1)
                        TOTAL_SIZE=$((TOTAL_SIZE + size))
                        human_size=$(human_readable $size)
                        echo -e "$file ${YELLOW}(${human_size})${RESET}"
                        FOUND_FILES+=("$file")
                    fi
                done < <(find "$dir" -type f -name "$pattern")
            done

            # Check if any files were found in this directory
            if [ ${#FOUND_FILES[@]} -eq 0 ]; then
                echo -e "${YELLOW}No backup files found in $dir.${RESET}"
            else
                total_human_size=$(human_readable $TOTAL_SIZE)
                echo -e "${YELLOW}Total size of found files: ${total_human_size}${RESET}"
                echo  # Blank line
                # Ask for confirmation before deletion for this directory
                echo -n -e "${BOLD}${CYAN}Do you want to delete these backup files in $dir? [y/N]: ${RESET}"
                read delete_confirm
                echo  # Blank line
                if [[ "$delete_confirm" =~ ^[Yy]$ ]]; then
                    echo -e "${BOLD}Clearing backup files in $dir...${RESET}"
                    for file in "${FOUND_FILES[@]}"; do
                        rm -f "$file" && echo -e "${GREEN}$file deleted.${RESET}" || echo -e "${RED}Failed to delete $file${RESET}"
                    done
                else
                    echo -e "${YELLOW}Backup file deletion canceled for $dir.${RESET}"
                fi
            fi
            echo  # Blank line
        else
            echo -e "${RED}Directory not found: $dir${RESET}"
        fi
    done
}
