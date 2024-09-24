#!/bin/bash

# Ensure the utils.sh is sourced to use color codes and other utilities
source ./utils.sh

# Clear Docker data function 
clear_docker_data() {
  echo -e "${BOLD}${BLUE}Docker Cleanup${RESET}"

  if ! command -v docker &> /dev/null; then
    echo -e "${YELLOW}Docker is not installed. Skipping Docker cleanup.${RESET}"
    return
  fi

  local containers images volumes

  # Display running and all containers, images, and volumes even if empty
  echo -e "\n${BOLD}Running Containers:${RESET}"
  sudo docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"
  echo -e "\n${BOLD}All Containers:${RESET}"
  sudo docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"
  echo -e "\n${BOLD}Docker Images:${RESET}"
  sudo docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.Size}}"

  # Check if there's any data present
  containers=$(sudo docker ps -a -q)
  images=$(sudo docker images -q)
  volumes=$(sudo docker volume ls -q)

  # Ask for confirmation only if there's data to delete
  if [[ -n "$containers" || -n "$images" || -n "$volumes" ]]; then
    read -p "${YELLOW}Remove Docker containers, images, and volumes? (y/n) ${RESET}" confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
      echo -e "${BOLD}Removing all Docker data...${RESET}"

      # Stop and remove running containers if any exist
      if [[ -n "$containers" ]]; then
        echo -e "${BOLD}Stopping containers...${RESET}"
        sudo docker stop $containers || true
        echo -e "${BOLD}Removing containers...${RESET}"
        sudo docker rm $containers || true
      fi

      # Remove images if any exist
      if [[ -n "$images" ]]; then
        echo -e "${BOLD}Removing images...${RESET}"
        sudo docker rmi $images || true
      fi

      # Remove volumes if any exist
      if [[ -n "$volumes" ]]; then
        echo -e "${BOLD}Removing volumes...${RESET}"
        sudo docker volume rm $volumes || true
      fi

      # Prune the system
      echo -e "${BOLD}Pruning the system...${RESET}"
      sudo docker system prune -af --volumes || true

      if [ $? -eq 0 ]; then
        echo -e "${GREEN}Docker data successfully removed.${RESET}\n"
      else
        echo -e "${RED}Failed to remove Docker data. Check permissions and Docker daemon status.${RESET}\n"
      fi
    else
      echo -e "${YELLOW}Skipping Docker data removal.${RESET}\n"
    fi
  else
    echo -e "${YELLOW}No Docker data found. Skipping removal.${RESET}\n"
  fi
}


# Perform advanced cleaning function
perform_advanced_cleaning() {
    echo -e "${BOLD}${BLUE}----------------------------------------------------------"
    echo -e "\nPerforming advanced cleaning...\n"
    echo -e "----------------------------------------------------------${RESET}"

    # Call Docker cleanup
    clear_docker_data
    
    # Shred sensitive files
    shred_files() {
        echo -e "\n${BOLD}${BLUE}Shredding sensitive files...${RESET}"
        find ~ -type f -name "*.sensitive" -exec shred -u {} \;
    }

    # Clear package cache
    clear_package_cache() {
        echo -e "\n${BOLD}${BLUE}Clearing package manager cache...${RESET}"
        sudo apt-get clean
        sudo apt-get autoclean
    }

    # Clear VPN and proxy configurations
    clear_vpn_proxy_configs() {
        echo -e "\n${BOLD}${BLUE}Clearing VPN and proxy configurations...${RESET}"
        sudo rm -rf /etc/openvpn/
        sudo rm -rf /etc/privoxy/
    }

    # Reset firewall rules
    reset_firewall_rules() {
        echo -e "\n${BOLD}${BLUE}Resetting firewall rules...${RESET}"
        sudo iptables -F
        sudo iptables -X
        sudo iptables -t nat -F
        sudo iptables -t nat -X
        sudo iptables -t mangle -F
        sudo iptables -t mangle -X
    }

    # Clear cron jobs
    clear_cron_jobs() {
        echo -e "\n${BOLD}${BLUE}Clearing cron jobs...${RESET}\n"
        crontab -r
        sudo rm -rf /etc/cron.d/*
        sudo rm -rf /var/spool/cron/crontabs/*
    }

    # Call the functions
    shred_files
    clear_package_cache
    clear_vpn_proxy_configs
    reset_firewall_rules
    clear_cron_jobs

    echo -e "\n${GREEN}Advanced cleaning completed.${RESET}\n"
}
