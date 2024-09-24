#!/bin/bash

source ./utils.sh

clean_browsers() {
    echo -e "\n${BOLD}${BLUE}----------------------------------------------------------"
    echo -e "\nCleaning browser data...\n"
    echo -e "----------------------------------------------------------${RESET}"

    # Locate Firefox profiles.ini file
    locate_profiles_ini() {
        profiles_ini_standard="$HOME/.mozilla/firefox/profiles.ini"
        profiles_ini_snap="$HOME/snap/firefox/common/.mozilla/firefox/profiles.ini"

        if [ -f "$profiles_ini_standard" ]; then
            echo "$profiles_ini_standard"
        elif [ -f "$profiles_ini_snap" ]; then
            echo "$profiles_ini_snap"
        else
            echo ""
        fi
    }

    # Locate Firefox profile directories
    locate_firefox_profiles() {
        firefox_base="$HOME/.mozilla/firefox/"
        firefox_snap_base="$HOME/snap/firefox/common/.mozilla/firefox/"

        firefox_dirs=$(find "$firefox_base" -type d -name "*default-release*" 2>/dev/null)
        if [ -z "$firefox_dirs" ]; then
            firefox_dirs=$(find "$firefox_base" -type d -name "*default*" 2>/dev/null)
        fi

        firefox_dirs_snap=$(find "$firefox_snap_base" -type d -name "*default-release*" 2>/dev/null)
        if [ -z "$firefox_dirs_snap" ]; then
            firefox_dirs_snap=$(find "$firefox_snap_base" -type d -name "*default*" 2>/dev/null)
        fi

        echo "$firefox_dirs $firefox_dirs_snap"
    }

    # Locate Chromium and Chrome profile directories
    locate_chrome_chromium_profiles() {
        chrome_base="$HOME/.config/google-chrome/"
        chrome_snap_base="$HOME/snap/google-chrome/common/.config/google-chrome/"
        chromium_base="$HOME/.config/chromium/"
        chromium_snap_base="$HOME/snap/chromium/common/.config/chromium/"

        chrome_dirs=$(find "$chrome_base" -type d -name "Default" 2>/dev/null)
        chrome_dirs_snap=$(find "$chrome_snap_base" -type d -name "Default" 2>/dev/null)
        chromium_dirs=$(find "$chromium_base" -type d -name "Default" 2>/dev/null)
        chromium_dirs_snap=$(find "$chromium_snap_base" -type d -name "Default" 2>/dev/null)

        echo "$chrome_dirs $chrome_dirs_snap $chromium_dirs $chromium_dirs_snap"
    }

    # Remove Firefox data
    remove_firefox_data() {
        profiles_ini=$(locate_profiles_ini)
        firefox_dirs=$(locate_firefox_profiles)

        echo -e "Located profiles.ini: $profiles_ini"
        echo -e "Located Firefox profile directories: $firefox_dirs"

        # Confirm deletion of profiles.ini
        if [ -n "$profiles_ini" ]; then
            read -p "${BOLD}${CYAN}Do you want to delete profiles.ini at $profiles_ini? (y/n) ${RESET}" confirm_profiles_ini
            if [[ "$confirm_profiles_ini" =~ ^[Yy]$ ]]; then
                echo -e "\n${BOLD}Deleting profiles.ini at $profiles_ini...${RESET}"
                rm "$profiles_ini"
                if [ $? -eq 0 ]; then
                    echo -e "${GREEN}profiles.ini successfully deleted.${RESET}\n"
                else
                    echo -e "${RED}Failed to delete profiles.ini. Check permissions and path.${RESET}\n"
                fi
            else
                echo -e "${YELLOW}Skipping deletion of profiles.ini.${RESET}\n"
            fi
        else
            echo -e "${YELLOW}profiles.ini not found.${RESET}\n"
        fi

        # Remove Firefox profile directories' contents but not the directories themselves
        if [ -n "$firefox_dirs" ]; then
            for dir in $firefox_dirs; do
                echo -e "Checking write permissions for $dir..."
                if [ -w "$dir" ] || [ "$(dirname "$dir")" = "$firefox_base" ] || [ "$(dirname "$dir")" = "$firefox_snap_base" ]; then
                    read -p "${BOLD}${CYAN}Do you want to clear Firefox data in $dir? (y/n) ${RESET}" confirm
                    if [[ "$confirm" =~ ^[Yy]$ ]]; then
                        echo -e "\n${BOLD}Clearing Firefox data...${RESET}"
                        rm -rf "$dir/*"
                        if [ $? -eq 0 ]; then
                            echo -e "${GREEN}Firefox data successfully cleared in $dir.${RESET}\n"
                        else
                            echo -e "${RED}Failed to clear Firefox data in $dir. Check permissions and path.${RESET}\n"
                        fi
                    else
                        echo -e "${YELLOW}Skipping clearing of Firefox data in $dir.${RESET}\n"
                    fi
                else
                    echo -e "${RED}No write permission for Firefox directory: $dir${RESET}\n"
                fi
            done
        else
            echo -e "${YELLOW}Firefox profile directories not found.${RESET}\n"
        fi
    }

    # Remove Chrome and Chromium data
    remove_chrome_chromium_data() {
        chrome_chromium_dirs=$(locate_chrome_chromium_profiles)

        echo -e "Located Chrome and Chromium profile directories: $chrome_chromium_dirs"

        # Remove Chrome and Chromium profile directories' contents but not the directories themselves
        if [ -n "$chrome_chromium_dirs" ]; then
            for dir in $chrome_chromium_dirs; do
                echo -e "Checking write permissions for $dir..."
                if [ -w "$dir" ] || [ "$(dirname "$dir")" = "$chrome_base" ] || [ "$(dirname "$dir")" = "$chrome_snap_base" ] || [ "$(dirname "$dir")" = "$chromium_base" ] || [ "$(dirname "$dir")" = "$chromium_snap_base" ]; then
                    read -p "${BOLD}${CYAN}Do you want to clear Chrome/Chromium data in $dir? (y/n) ${RESET}" confirm
                    if [[ "$confirm" =~ ^[Yy]$ ]]; then
                        echo -e "\n${BOLD}Clearing Chrome/Chromium data...${RESET}"
                        rm -rf "$dir/*"
                        if [ $? -eq 0 ]; then
                            echo -e "${GREEN}Chrome/Chromium data successfully cleared in $dir.${RESET}\n"
                        else
                            echo -e "${RED}Failed to clear Chrome/Chromium data in $dir. Check permissions and path.${RESET}\n"
                        fi
                    else
                        echo -e "${YELLOW}Skipping clearing of Chrome/Chromium data in $dir.${RESET}\n"
                    fi
                else
                    echo -e "${RED}No write permission for Chrome/Chromium directory: $dir${RESET}\n"
                fi
            done
        else
            echo -e "${YELLOW}Chrome and Chromium profile directories not found.${RESET}\n"
        fi
    }

    # Clear browser extensions
    clear_browser_extensions() {
        echo -e "Located Firefox extensions directory: ~/.mozilla/firefox/*.default-release/extensions/"
        echo -e "Located Chrome extensions directory: ~/.config/google-chrome/Default/Extensions/"

        # Confirm deletion of Firefox extensions
        read -p "${BOLD}${CYAN}Do you want to remove Firefox extensions? This action will delete all Firefox extensions data. (y/n) " confirm_firefox
        if [[ "$confirm_firefox" =~ ^[Yy]$ ]]; then
            echo -e "\n${BOLD}Removing Firefox extensions...${RESET}"
            rm -rf ~/.mozilla/firefox/*.default-release/extensions/
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}Firefox extensions successfully removed.${RESET}\n"
            else
                echo -e "${RED}Failed to remove Firefox extensions. Check permissions and path.${RESET}\n"
            fi
        else
            echo -e "${YELLOW}Skipping removal of Firefox extensions.${RESET}\n"
        fi

        # Confirm deletion of Chrome extensions
        read -p "${BOLD}${CYAN}Do you want to remove Chrome extensions? This action will delete all Chrome extensions data. (y/n) ${RESET}" confirm_chrome
        if [[ "$confirm_chrome" =~ ^[Yy]$ ]]; then
            echo -e "\n${BOLD}Removing Chrome extensions...${RESET}"
            rm -rf ~/.config/google-chrome/Default/Extensions/
            if [ $? -eq 0 ]; then
                echo -e "${GREEN}Chrome extensions successfully removed.${RESET}\n"
            else
                echo -e "${RED}Failed to remove Chrome extensions. Check permissions and path.${RESET}\n"
            fi
        else
            echo -e "${YELLOW}Skipping removal of Chrome extensions.${RESET}\n"
        fi
    }

    # Call the functions
    remove_firefox_data
    remove_chrome_chromium_data
    clear_browser_extensions
}