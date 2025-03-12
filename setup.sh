#!/bin/bash

export PROJECT_REPO=git@github.com:karimPortfolio/deploy-node-app.git
export PROJECT_NAME=deploy-node-app

#update system
sudo yum update -y

# Install Git if not already installed
echo "Checking if Git is installed..."
if ! git --version &>/dev/null; then
  echo "Git is not installed. Installing Git..."
  sudo yum install git -y
else
  echo "Git is already installed."
fi

# Install Nodejs if not installed
if ! node -v &>/dev/null; then
  echo 'Nodejs is not installed. Installing Nodejs'
  sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
  nvm install --lts
  nvm use --lts
else 
  echo 'Nodejs already installed'
fi

# Install PM2 if not installed
if ! pm2 -v &>/dev/null; then
  echo 'PM2 is not installed. Installing PM2'
  npm install pm2 -g
else 
  echo 'PM2 already installed'
fi

# Install supervisor
if ! supervisor -v &>/dev/null; then
  echo 'Supervisor is not installed. Installing Supervisor'
  sudo npm install supervisor -g
else 
  echo 'Supervisor already installed'
fi


# Clone project
echo "cloning project from $PROJECT_REPO ..."
GIT_SSH_COMMAND="ssh -i /home/ec2-user/.ssh/deploy_key" git clone "$PROJECT_REPO"


# Navigate into the project folder
cd "$PROJECT_NAME" || { echo "Failed to enter directory $PROJECT_NAME"; exit 1; }

# Install dependecies
echo "Installing dependecies..."
sudo npm i

# Set up the .env file
echo "Setting up the .env file..."
cp .env.example .env

# Starting application
sudo npm start

# Save PM2 process list and setup startup script
pm2 save
pm2 startup

echo "Congrats!! You're live now ;)"
