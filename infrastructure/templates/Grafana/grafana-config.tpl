#!/bin/bash

LOG_FILE="/var/log/user_data.log"

# Log function to simplify logging
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" | tee -a $LOG_FILE
}

# Step 1: Update the package lists to get the latest version information
log "Updating package lists..."
sudo apt-get -y update >> $LOG_FILE 2>&1

# Step 2: Upgrade all installed packages to their latest versions
log "Upgrading installed packages..."
sudo apt-get -y upgrade >> $LOG_FILE 2>&1

# Step 3: Remove any old versions of Docker, if they exist
log "Removing old Docker versions (if any)..."
sudo apt-get -y remove docker docker-engine docker.io containerd runc >> $LOG_FILE 2>&1

# Step 4: Install necessary packages for Docker and other tools
log "Installing prerequisite packages..."
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release awscli git jq >> $LOG_FILE 2>&1

# Step 5: Add Docker's GPG key
log "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg >> $LOG_FILE 2>&1

# Step 6: Add Docker's official repository
log "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null >> $LOG_FILE 2>&1

# Step 7: Update the package lists again to include Docker repository
log "Updating package lists with Docker repository..."
sudo apt-get update >> $LOG_FILE 2>&1

# Step 8: Install Docker CE (Community Edition) and Docker CLI
log "Installing Docker..."
sudo apt-get -y install docker-ce docker-ce-cli containerd.io >> $LOG_FILE 2>&1

# Step 9: Install Docker Compose
log "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose >> $LOG_FILE 2>&1

# Step 10: Give execution permissions to Docker Compose
log "Making Docker Compose executable..."
sudo chmod +x /usr/local/bin/docker-compose >> $LOG_FILE 2>&1

# Step 11: Create a symbolic link for Docker Compose
log "Creating symlink for Docker Compose..."
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose >> $LOG_FILE 2>&1

# Step 12: Verify Docker Compose installation
log "Verifying Docker Compose installation..."
docker-compose --version >> $LOG_FILE 2>&1

# Step 13: Add current user to Docker group
log "Adding current user to Docker group..."
sudo usermod -aG docker $USER >> $LOG_FILE 2>&1

# Step 14: Apply Docker group membership without logout
log "Applying new group membership for Docker..."
newgrp docker >> $LOG_FILE 2>&1

# Step 15: Enable Docker and containerd services to start on boot
log "Enabling Docker service..."
sudo systemctl enable docker.service >> $LOG_FILE 2>&1

log "Enabling containerd service..."
sudo systemctl enable containerd.service >> $LOG_FILE 2>&1

# Step 16: Create directory for Grafana
log "Creating Grafana directory..."
sudo -u ubuntu mkdir -p /home/ubuntu/grafana >> $LOG_FILE 2>&1
if [ -d "/home/ubuntu/grafana" ]; then
    log "Grafana directory created successfully."
else
    log "Failed to create Grafana directory."
fi

# Step 17: Create Docker Compose file for Grafana
log "Creating Docker Compose file for Grafana..."
cat << EOF > /home/ubuntu/grafana/docker-compose.yaml
---
version: "3.8"
services:
  grafana:
    image: grafana/grafana:9.5.2
    ports:
      - "3000:3000"
    restart: unless-stopped
EOF

if [ -f "/home/ubuntu/grafana/docker-compose.yaml" ]; then
    log "Docker Compose file created successfully."
else
    log "Failed to create Docker Compose file."
fi

# Step 18: Start Grafana using Docker Compose
log "Starting Grafana service with Docker Compose..."
cd /home/ubuntu/grafana
docker-compose up -d >> $LOG_FILE 2>&1

log "Script execution completed."
