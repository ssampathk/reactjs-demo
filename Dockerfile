# ---- Build Stage ----
FROM node:14 AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the source code
COPY . .

# Build the React app
RUN npm run build

# ---- Serve Stage ----
FROM nginx:alpine

# Copy the build folder from build stage to nginx
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
