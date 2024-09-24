clear_shell_history() {
    echo -e "${BOLD}${BLUE}----------------------------------------------------------"
    echo -e "\nCleaning shell history...\n"
    echo -e "----------------------------------------------------------${RESET}"

    # Locate .bash_history and .zsh_history files
    echo -e "${BOLD}Locating Bash history files...${RESET}"
    bash_history_files=()
    while IFS= read -r -d '' file; do
        bash_history_files+=("$file")
    done < <(find / -type f -name '.bash_history' 2>/dev/null -print0)

    if [ ${#bash_history_files[@]} -eq 0 ]; then
        echo -e "${YELLOW}No Bash history files found.${RESET}"
    else
        echo -e "${BOLD}Found Bash history files:${RESET}"
        for file in "${bash_history_files[@]}"; do
            echo "$file"
        done

        # Ask for confirmation to clear .bash_history files
        read -p "${YELLOW}Do you want to clear all listed Bash history files? (y/n) ${RESET}" confirm_bash
        if [[ "$confirm_bash" =~ ^[Yy]$ ]]; then
            for file in "${bash_history_files[@]}"; do
                echo "Removing $file"
                sudo rm -f "$file"
            done
            history -c
            history -w
            echo -e "${GREEN}Bash history cleared.${RESET}"
        else
            echo -e "${YELLOW}Skipping Bash history clearance.${RESET}"
        fi
    fi

    echo -e "${BOLD}Locating Zsh history files...${RESET}"
    zsh_history_files=()
    while IFS= read -r -d '' file; do
        zsh_history_files+=("$file")
    done < <(find / -type f -name '.zsh_history' 2>/dev/null -print0)

    if [ ${#zsh_history_files[@]} -eq 0 ]; then
        echo -e "${YELLOW}No Zsh history files found.${RESET}"
    else
        echo -e "${BOLD}Found Zsh history files:${RESET}"
        for file in "${zsh_history_files[@]}"; do
            echo "$file"
        done

        # Ask for confirmation to clear .zsh_history files
        read -p "${YELLOW}Do you want to clear all listed Zsh history files? (y/n) ${RESET}" confirm_zsh
        if [[ "$confirm_zsh" =~ ^[Yy]$ ]]; then
            for file in "${zsh_history_files[@]}"; do
                echo "Removing $file"
                sudo rm -f "$file"
            done
            echo -e "${GREEN}Zsh history cleared.${RESET}"
        else
            echo -e "${YELLOW}Skipping Zsh history clearance.${RESET}"
        fi
    fi

    # Sync filesystem to ensure changes are written
    echo -e "${BOLD}Syncing filesystem to ensure changes are written...${RESET}\n"
    sync

    echo -e "${YELLOW}Note: Changes to shell history may not be immediately visible in the current terminal session.\nPlease restart your terminal to see the updates.${RESET}\n"

}
