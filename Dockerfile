# Build stage
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies from lockfile (devDependencies include webpack toolchain)
RUN npm ci

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

# Copy nginx configuration template (envsubst at container start)
COPY nginx.conf.template /etc/nginx/templates/default.conf.template
ENV DOCKER_API_UPSTREAM=docker-socket:2375
ENV NGINX_ENVSUBST_FILTER=DOCKER_API_UPSTREAM

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 
