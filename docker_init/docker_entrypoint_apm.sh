./generate_env_config.sh > /usr/share/nginx/html/env-config.js
./generate_dd_config.sh > /etc/nginx/dd-config.json
nginx -g "daemon off;"