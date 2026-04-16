# Use official Node.js image
FROM node:24-alpine

# Set working directory inside the container
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json .
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose port 5500
EXPOSE 5500

# Start the application
CMD ["node", "index.js"]
