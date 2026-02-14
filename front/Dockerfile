# Stage 1: Build Angular
FROM node:20-alpine AS build
WORKDIR /app

## Copier UNIQUEMENT package.json et package-lock.json
## Cette couche sera cachée tant que ces fichiers ne changent pas
COPY package.json package-lock.json ./

## Utiliser npm ci au lieu de npm install (plus rapide et déterministe)
RUN npm ci --prefer-offline

## Copier le code source (APRÈS avoir caché node_modules)
COPY . .

## Build en mode production
RUN npm run build -- --configuration production

# Stage 2: Nginx
FROM nginx:alpine

## Supprimer la config nginx par défaut
RUN rm -rf /usr/share/nginx/html/*

## Copier les fichiers buildés depuis le stage de build
COPY --from=build /app/dist/olympic-games-starter/browser /usr/share/nginx/html

## Copier la configuration nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

## L'utilisateur nginx existe déjà dans l'image nginx:alpine
## Modifier les permissions pour cet utilisateur
RUN chown -R nginx:nginx /usr/share/nginx/html && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chmod -R 755 /usr/share/nginx/html && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid

## Passer à l'utilisateur non-root nginx (déjà existant)
USER nginx

## Port 8080 (accessible en non-root)
EXPOSE 8080

## Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/ || exit 1

## Démarrer nginx
CMD ["nginx", "-g", "daemon off;"]