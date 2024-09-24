# main.sh

# Ensure the utils.sh is sourced to use color codes and other utilities
source ./utils.sh

# Import all cleaner modules
source ./browser_cleaner.sh
source ./system_cleaner.sh
source ./app_cleaner.sh
source ./user_security_cleaner.sh
source ./network_user_cleaner.sh
source ./advanced_cleaner.sh
source ./back_up_remove.sh
source ./shell_cleaner.sh  

# Display banner
display_banner

# Main execution block
echo -e "\n${BOLD}${BLUE}Starting secure clean-up process...${RESET}\n"

# Confirm user action
read -p "${YELLOW}WARNING: Do you want to proceed with the clean-up? This will remove browser data, history, and logs. (y/n) ${RESET}" choice

if [[ "$choice" =~ ^[Yy]$ ]]; then
    # Call functions from each module
    clean_browsers
    clean_system
    clean_applications
    clean_security
    clean_network_and_user
    perform_advanced_cleaning
    clear_backup_files
    clear_shell_history 

    echo -e "${BOLD}${GREEN}-------------------------------------------------------------------------------------------------------------"
    echo -e "\nThat's it. Security clean-up process completed. I hope you didn't accidentally delete anything important...\n"
    echo -e "-------------------------------------------------------------------------------------------------------------${RESET}\n"
else
    echo -e "\n${YELLOW}Security clean-up process aborted.${RESET}\n"
fi
