#!/bin/sh

# Variables
BACKEND_PORT=$1
FRONTEND_PORT=$2
DB_PATH="/home/frog/the-mars-mission/backend/db/astronauts.db"
BACKUP_DB_PATH="/home/frog/the-mars-mission/backup/astronauts.db"
BACKEND_DIR="/home/frog/the-mars-mission/backend"
FRONTEND_DIR="/home/frog/the-mars-mission/frontend"
FROG_LOGIN=$3
FROG_PASSWORD=$4
FROG_URL=$5
FROG_PORT=$6

# Check if the backend db folder exists, if not, create it
if [ ! -d "/home/frog/the-mars-mission/backend/db" ]; then
  echo "Creating backend db directory..."
  mkdir -p /home/frog/the-mars-mission/backend/db
fi

# 1. Check if the app runs
echo "Checking if the app is running..."
if netstat -tulnp | grep -q ":$BACKEND_PORT"; then
  echo "Backend app is running on port $BACKEND_PORT"
else
  echo "Backend app is not running"
fi

if netstat -tulnp | grep -q ":$FRONTEND_PORT"; then
  echo "Frontend app is running on port $FRONTEND_PORT"
else
  echo "Frontend app is not running"
fi

# 2. Stop all apps
echo "Stopping all apps..."
netstat -tulnp | grep :$BACKEND_PORT | awk '{print $7}' | awk -F/ '{print $1}' | xargs kill
netstat -tulnp | grep :$FRONTEND_PORT | awk '{print $7}' | awk -F/ '{print $1}' | xargs kill

# 3. Copy the db path to a safe separate file
echo "Backing up the database..."
cp $DB_PATH $BACKUP_DB_PATH

# 4. Delete app files
echo "Deleting app files..."
rm -rf $BACKEND_DIR/*
rm -rf $FRONTEND_DIR/*

# 5. Download the build
echo "Downloading the build..."
curl -u $FROG_LOGIN:$FROG_PASSWORD -O $FROG_URL:$FROG_PORT/home/frog/the-mars-mission/backend-files.tar.gz
curl -u $FROG_LOGIN:$FROG_PASSWORD -O $FROG_URL:$FROG_PORT/home/frog/the-mars-mission/frontend-build.tar.gz

# 6. Restore the db file
echo "Restoring the database..."
cp $BACKUP_DB_PATH $DB_PATH

# 7. Start the backend app
echo "Starting the backend app..."
cd $BACKEND_DIR
tar -xzf ../backend-files.tar.gz
npm start &

# 8. Install serve
echo "Installing serve..."
npm install -g serve

# 9. Start the frontend app
echo "Starting the frontend app..."
cd $FRONTEND_DIR
tar -xzf ../frontend-build.tar.gz
serve -s build -l $FRONTEND_PORT &

# Clean up
echo "Cleaning up..."
rm ../backend-files.tar.gz
rm ../frontend-build.tar.gz