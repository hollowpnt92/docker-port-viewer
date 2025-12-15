# Build stage
FROM node:20-alpine AS builder

WORKDIR /app

# Update packages to get latest security patches
RUN apk add --no-cache ca-certificates

# Copy package files
COPY package*.json ./

# Install dependencies including webpack and its dependencies
RUN npm install && \
    npm install --save-dev webpack webpack-cli webpack-dev-server typescript ts-loader html-webpack-plugin style-loader css-loader

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Production stage
FROM nginx:alpine

# Update packages to get latest security patches (including libpng)
RUN apk update && rm -rf /var/cache/apk/*

# Copy built assets from builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 
