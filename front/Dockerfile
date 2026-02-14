# First_step : Build Angular
FROM node:20-alpine AS build
WORKDIR /app
COPY package.json package-lock.json* ./
RUN npm install
COPY . .
RUN npm run build

# Second_step : Nginx
FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*

COPY --from=build /app/dist/olympic-games-starter/browser /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Permissions
RUN chmod -R 755 /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
