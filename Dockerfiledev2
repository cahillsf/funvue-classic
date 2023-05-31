FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
COPY vuikit.css ./node_modules/@vuikit/theme/dist/
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY ./docker_init ./
RUN rm -rf /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d
RUN chmod +x ./docker_entrypoint.sh ./generate_env_config.sh
EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]
CMD ["/bin/sh", "docker_entrypoint.sh"]