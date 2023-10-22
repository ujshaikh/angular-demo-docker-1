# Step 1: Build the app in image 'builder'
FROM node:lts-alpine AS build
RUN npm install -g npm
WORKDIR /app
COPY . .
# install and cache app dependencies
# COPY package*.json ./
# COPY angular.json /app/angular.json
# COPY tsconfig*.json ./

RUN npm install
RUN npm run build --prod
# RUN npm run build
# RUN npm install -g @angular/cli

# Production stage
FROM nginx:stable-alpine
# RUN ls /app
COPY --from=build /app/dist/docker-app /usr/share/nginx/html
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]
