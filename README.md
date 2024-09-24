<img src="security_cleaner.jpg" alt="Security Cleaner App"/>

# Security Cleaner

Security Cleaner is a comprehensive script that helps you securely clean up various types of data from your Linux system. It's designed with a modular approach, allowing you to easily maintain and extend the functionality as needed. 

## Modular Structure 

The script is divided into several modules, each responsible for a specific category of cleaning tasks: 
- `utils.sh`: Colour options, banner and other functions. 
- `browser_cleaner.sh`: Handles the removal of browser data, including Firefox and Chrome/Chromium profiles and extensions. 
- `system_cleaner.sh`: Focuses on clearing system logs and temporary files. 
- `app_cleaner.sh`: Cleans up application-specific data, such as email client (Thunderbird) data. In this version of the app data deletion includes: Office Suite, Keepassxc, Dropbox and Nextcloud, data from developer tools (Like Pycharm or VSCodium), SQLite Browser and Torrent Client. This can be modified depending on user specifications. 
- `user_security_cleaner.sh`: Manages the removal of security-related data, like SSH keys, GPG keys, saved passwords and Keepass Databases. 
- `network_user_cleaner.sh`: Handles the cleaning of network configurations, user logs, and clipboard history. 
- `advanced_cleaner.sh`: Performs more advanced cleaning tasks, such as Docker data removal, file shredding, package cache, cron jobs and firewall rule reset. 
- `back_up_remove.sh`: Removes backup files in specified directories. Formats : .bak .zip .iso .tar.gz. This can be modified to user preferences. 
- `shell_cleaner.sh`: Removes the shell history for the current user. (Bash or Zsh)

This modular structure makes it easier to maintain and extend the script, as each module can be updated or added without affecting the overall functionality.

## Installation and Usage 

To use the Secure Cleaner, follow these steps: 

1. Clone the repository:``

```bash
git clone https://github.com/meryantona/security_cleaner.git
```

2. Change to the project directory:`

```bash
cd security_cleaner
```

3. Make the main script executable:`

```bash
chmod +x main.sh
```

4. Run the script:`

```bash
./main.sh
```

The script will prompt you for confirmation before performing any actions. You can selectively choose which cleaning tasks to execute based on your needs. 

## Contributing 

If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request. Contributions are always welcome! 

## License 

This project is licensed under the [MIT License](LICENSE).
