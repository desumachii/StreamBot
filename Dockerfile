# Use the official nodejs 22 alpine image as the base image
FROM node:22-alpine

# Set the working directory
WORKDIR /home/bots/StreamBot

# Install important deps
RUN apk --no-cache add --virtual .builds-deps build-base python3 ffmpeg

# Install pnpm
RUN npm install pnpm -g

# Copy package.json
COPY package.json ./

# Install dependencies
RUN pnpm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN pnpm run build

# Specify the port number the container should expose
EXPOSE 3000

# Create videos folder
RUN mkdir -p ./videos

# Command to run the application
CMD ["pnpm", "run", "start"]