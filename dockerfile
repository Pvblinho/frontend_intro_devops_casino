# ETAPA 1: Build de Angular
FROM node:20-alpine AS build_stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --configuration production

# ETAPA 2: Servidor Web (Nginx)
FROM nginxinc/nginx-unprivileged:alpine
# Reemplaza la línea que causa el error por esta:
COPY --from=build_stage /app/dist/casino-frontend/browser /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080