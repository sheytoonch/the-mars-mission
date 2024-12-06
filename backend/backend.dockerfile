# Use an official Node.js runtime as the base image
FROM node:14 AS builder

# Set the working directory in the container
WORKDIR /mars_mission

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install --only=production

# Copy the rest of the application code to the working directory
COPY . .

# Rebuild native modules
RUN npm rebuild sqlite3 --build-from-source

# Expose a port
EXPOSE 3001

# Multistage build start
# Optimization of docker image size from 1150MB/950MB to 217MB
# Debian-based Node.js runtime as the base image for the final stage.
#
# sqlite3 module is failing to load due to a missing symbol (fcntl64.
# To resolve this issue, you can use a Debian-based Node.js image for
# the final stage instead of the Alpine-based image. Debian-based images
# use glibc, which is more compatible with native modules.
FROM node:14-slim

WORKDIR /mars_mission

COPY --from=builder /mars_mission /mars_mission

# Define the command to run your application / check package.json scripts
CMD [ "npm", "start" ]
