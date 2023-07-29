# Use the official Node.js image as the base image
FROM node:current-alpine3.18 as build-stage

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install -g npm@9.8.1 && npm install

# Copy the rest of the app's source code to the container
COPY . .

# Build the production version of the Vue.js app
RUN npm run build

# Use the nginx:1.21 image as the base for the final production image
FROM nginx:1.21

# Copy the built files from the previous stage to the NGINX web root directory
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expose port for the NGINX server
EXPOSE 8080

# Start NGINX when the container starts
CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
