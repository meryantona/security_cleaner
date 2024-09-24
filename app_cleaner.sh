#!/bin/bash
source ./utils.sh

clean_applications() {
    echo -e "${BOLD}${BLUE}----------------------------------------------------------"
    echo -e "\nCleaning application data...\n"
    echo -e "----------------------------------------------------------${RESET}"

    # Clear application-specific data (add more as needed, base function)
    clear_application_data() {
        echo -e "\n${BOLD}${YELLOW}Clearing application-specific data...${RESET}"
        if [ -d ~/.local/share/app ] && [ "$(ls -A ~/.local/share/app)" ]; then
            local size=$(du -sb ~/.local/share/app 2>/dev/null | cut -f1)
            echo -e "Application data size: ${CYAN}$(human_readable $size)${RESET}"
            read -p "${BOLD}${CYAN}Are you sure you want to delete application data in ~/.local/share/app/? (y/n) ${RESET}" confirm
            if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
                rm -rf ~/.local/share/app/*
                echo -e "${GREEN}Application data deleted.${RESET}"
            else
                echo -e "${YELLOW}Skipping application data deletion.${RESET}"
            fi
        else
            echo -e "${YELLOW}No application data found to delete.${RESET}"
        fi
    }

    # Clear email clients data
    clear_email_clients() {
        echo -e "\n${BOLD}${YELLOW}Clearing Email Client Data${RESET}"
        if [ -d ~/.thunderbird ] && [ "$(ls -A ~/.thunderbird)" ]; then
            local size=$(du -sb ~/.thunderbird 2>/dev/null | cut -f1)
            echo -e "Thunderbird data size: ${CYAN}$(human_readable $size)${RESET}"
            read -p "${BOLD}${CYAN}Are you sure you want to delete Thunderbird data in ~/.thunderbird/? (y/n) ${RESET}" confirm
            if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
                rm -rf ~/.thunderbird/*
                echo -e "${GREEN}Thunderbird data deleted.${RESET}"
            else
                echo -e "${YELLOW}Skipping Thunderbird data deletion.${RESET}"
            fi
        else
            echo -e "${YELLOW}No Thunderbird data found to delete.${RESET}"
        fi
    }

    # Clear Office Suite data
    clear_office_suite_data() {
        echo -e "\n${BOLD}${YELLOW}Clearing Office Suite Data${RESET}"
        if [ -d ~/.config/libreoffice ] && [ "$(ls -A ~/.config/libreoffice)" ]; then
            local size=$(du -sb ~/.config/libreoffice 2>/dev/null | cut -f1)
            echo -e "LibreOffice data size: ${CYAN}$(human_readable $size)${RESET}"
            read -p "${BOLD}${CYAN}Are you sure you want to delete LibreOffice data in ~/.config/libreoffice/? (y/n) ${RESET}" confirm
            if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
                rm -rf ~/.config/libreoffice/*
                echo -e "${GREEN}LibreOffice data deleted.${RESET}"
            else
                echo -e "${YELLOW}Skipping LibreOffice data deletion.${RESET}"
            fi
        else
            echo -e "${YELLOW}No LibreOffice data found to delete.${RESET}"
        fi
    }

    # Clear Password Manager data
    clear_password_manager_data() {
        echo -e "\n${BOLD}${YELLOW}Clearing Password Manager Data${RESET}"
        if [ -d ~/.config/keepassxc ] && [ "$(ls -A ~/.config/keepassxc)" ]; then
            local size=$(du -sb ~/.config/keepassxc 2>/dev/null | cut -f1)
            echo -e "KeePassXC data size: ${CYAN}$(human_readable $size)${RESET}"
            read -p "${BOLD}${CYAN}Are you sure you want to delete KeePassXC data in ~/.config/keepassxc/? (y/n) ${RESET}" confirm
            if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
                rm -rf ~/.config/keepassxc/*
                echo -e "${GREEN}KeePassXC data deleted.${RESET}"
            else
                echo -e "${YELLOW}Skipping KeePassXC data deletion.${RESET}"
            fi
        else
            echo -e "${YELLOW}No KeePassXC data found to delete.${RESET}"
        fi
    }

    # Clear Cloud Storage Client data
    clear_cloud_storage_data() {
        echo -e "\n${BOLD}${YELLOW}Clearing Cloud Storage Client Data${RESET}"
        if [ -d ~/Dropbox ] && [ "$(ls -A ~/Dropbox)" ]; then
            local dropbox_size=$(du -sb ~/Dropbox 2>/dev/null | cut -f1)
            echo -e "Dropbox data size: ${CYAN}$(human_readable $dropbox_size)${RESET}"
            read -p "${BOLD}${CYAN}Are you sure you want to delete Dropbox data in ~/Dropbox/? (y/n) ${RESET}" confirm
            if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
                rm -rf ~/Dropbox/*
                echo -e "${GREEN}Dropbox data deleted.${RESET}"
            else
                echo -e "${YELLOW}Skipping Dropbox data deletion.${RESET}"
            fi
        else
            echo -e "${YELLOW}No Dropbox data found to delete.${RESET}"
        fi

        if [ -d ~/.config/Nextcloud ] && [ "$(ls -A ~/.config/Nextcloud)" ]; then
            local nextcloud_size=$(du -sb ~/.config/Nextcloud 2>/dev/null | cut -f1)
            echo -e "Nextcloud data size: ${CYAN}$(human_readable $nextcloud_size)${RESET}"
            read -p "${BOLD}${CYAN}Are you sure you want to delete Nextcloud data in ~/.config/Nextcloud/? (y/n) ${RESET}" confirm
            if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
                rm -rf ~/.config/Nextcloud/*
                echo -e "${GREEN}Nextcloud data deleted.${RESET}"
            else
                echo -e "${YELLOW}Skipping Nextcloud data deletion.${RESET}"
            fi
        else
            echo -e "${YELLOW}No Nextcloud data found to delete.${RESET}"
        fi
    }

    # Clear Development Tool data
    clear_dev_tool_data() {
        echo -e "\n${BOLD}${YELLOW}Clearing Development Tool Data${RESET}"
        if [ -d ~/.config/VSCodium ] && [ "$(ls -A ~/.config/VSCodium)" ]; then
            local vscode_size=$(du -sb ~/.config/VSCodium 2>/dev/null | cut -f1)
            echo -e "VS Code data size: ${CYAN}$(human_readable $vscode_size)${RESET}"
            read -p "${BOLD}${CYAN}Are you sure you want to delete VS Code data in ~/.config/VSCodium/? (y/n) ${RESET}" confirm
            if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
                rm -rf ~/.config/Code/*
                echo -e "${GREEN}VS Code data deleted.${RESET}"
            else
                echo -e "${YELLOW}Skipping VS Code data deletion.${RESET}"
            fi
        else
            echo -e "${YELLOW}No VS Code data found to delete.${RESET}"
        fi

        if [ -d ~/.config/JetBrains/PyCharm* ] && [ "$(ls -A ~/.config/JetBrains/PyCharm*)" ]; then
            local pycharm_size=$(du -sb ~/.config/JetBrains/PyCharm* 2>/dev/null | cut -f1)
            echo -e "PyCharm data size: ${CYAN}$(human_readable $pycharm_size)${RESET}"
            read -p "${BOLD}${CYAN}Are you sure you want to delete PyCharm data in ~/.config/JetBrains/PyCharm*/? (y/n) ${RESET}" confirm
            if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
                rm -rf ~/.config/JetBrains/PyCharm*/*
                echo -e "${GREEN}PyCharm data deleted.${RESET}"
            else
                echo -e "${YELLOW}Skipping PyCharm data deletion.${RESET}"
            fi
        else
            echo -e "${YELLOW}No PyCharm data found to delete.${RESET}"
        fi
    }

    # Clear SQLite Browser data
    clear_sqlite_browser_data() {
        echo -e "\n${BOLD}${YELLOW}Clearing SQLite Browser Data${RESET}"
        if [ -d ~/.config/sqlitebrowser ] && [ "$(ls -A ~/.config/sqlitebrowser)" ]; then
            local size=$(du -sb ~/.config/sqlitebrowser 2>/dev/null | cut -f1)
            echo -e "SQLite Browser data size: ${CYAN}$(human_readable $size)${RESET}"
            read -p "${BOLD}${CYAN}Are you sure you want to delete SQLite Browser data in ~/.config/sqlitebrowser/? (y/n) ${RESET}" confirm
            if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
                rm -rf ~/.config/sqlitebrowser/*
                echo -e "${GREEN}SQLite Browser data deleted.${RESET}"
            else
                echo -e "${YELLOW}Skipping SQLite Browser data deletion.${RESET}"
            fi
        else
            echo -e "${YELLOW}No SQLite Browser data found to delete.${RESET}"
        fi
    }


    # Clear BitTorrent Client data
    clear_torrent_client_data() {
        echo -e "\n${BOLD}${YELLOW}Clearing BitTorrent Client Data${RESET}"
        if [ -d ~/.config/transmission ] && [ "$(ls -A ~/.config/transmission)" ]; then
            local transmission_size=$(du -sb ~/.config/transmission 2>/dev/null | cut -f1)
            echo -e "Transmission data size: ${CYAN}$(human_readable $transmission_size)${RESET}"
            read -p "${BOLD}${CYAN}Are you sure you want to delete Transmission data in ~/.config/transmission/? (y/n) ${RESET}" confirm
            if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
                rm -rf ~/.config/transmission/*
                echo -e "${GREEN}Transmission data deleted.${RESET}"
            else
                echo -e "${YELLOW}Skipping Transmission data deletion.${RESET}"
            fi
        else
            echo -e "${YELLOW}No Transmission data found to delete.${RESET}"
        fi

        if [ -d ~/.config/qBittorrent ] && [ "$(ls -A ~/.config/qBittorrent)" ]; then
            local qbittorrent_size=$(du -sb ~/.config/qBittorrent 2>/dev/null | cut -f1)
            echo -e "qBittorrent data size: ${CYAN}$(human_readable $qbittorrent_size)${RESET}"
            read -p "${BOLD}${CYAN}Are you sure you want to delete qBittorrent data in ~/.config/qBittorrent/? (y/n) ${RESET}" confirm
            if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
                rm -rf ~/.config/qBittorrent/*
                echo -e "${GREEN}qBittorrent data deleted.${RESET}"
            else
                echo -e "${YELLOW}Skipping qBittorrent data deletion.${RESET}"
            fi
        else
            echo -e "${YELLOW}No qBittorrent data found to delete.${RESET}"
        fi
    }

    # Call the functions
    clear_application_data
    clear_email_clients
    clear_office_suite_data
    clear_password_manager_data
    clear_cloud_storage_data
    clear_dev_tool_data
    clear_sqlite_browser_data
    clear_torrent_client_data
    

    echo -e "\n${BOLD}${GREEN}Application data cleaning complete.${RESET}"
}