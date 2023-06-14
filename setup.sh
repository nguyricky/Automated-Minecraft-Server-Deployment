#!/bin/bash

# SSH into EC2 instance
ssh -i ~/.ssh/id_rsa ubuntu@{IP}<< 'EOF'

# Update packages
sudo apt update
sudo apt upgrade -y

# Add OpenJDK repositorys
sudo add-apt-repository -y ppa:openjdk-r/ppa
sudo apt update

# Install OpenJDK
sudo apt install -y openjdk-17-jre-headless

# Download Minecraft Server jar
wget -O /home/ubuntu/server.jar https://piston-data.mojang.com/v1/objects/84194a2f286ef7c14ed7ce0090dba59902951553/server.jar

# Modify file permissions
sudo chmod 0777 /home/ubuntu/server.jar

# Run Minecraft server
java -Xms1024M -Xmx1024M -jar /home/ubuntu/server.jar nogui

# Sleep for 10 seconds
sleep 10

# Accept the EULA
sudo sed -i 's/eula=false/eula=true/' /home/ubuntu/eula.txt

# Create systemd service file
sudo tee /etc/systemd/system/mcserver.service > /dev/null <<EOT
[Unit]
Description=Manage Java service

[Service]
WorkingDirectory=/home/ubuntu/
ExecStart=/bin/java -Xms1024M -Xmx1024M -jar /home/ubuntu/server.jar nogui
User=ubuntu
Type=simple
Restart=on-failure
RestartSec=2

[Install]
WantedBy=multi-user.target
EOT

# Start and enable mcserver.service
sudo systemctl start mcserver.service
sudo systemctl enable mcserver.service
sudo systemctl daemon-reload
EOF
