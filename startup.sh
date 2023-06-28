DD_API_KEY=<DD_API_KEY> DD_SITE="datadoghq.com" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script_agent7.sh)"print
printf '%s\n' 'DD_ENV=dev' 'DD_SERVICE=ps-vue-ls' 'DD_VERSION=0.0.3' 'DD_PS_APP_ID=199c6858-0b0b-4b4a-a64f-f0fc03b3cce2' 'DD_PS_CLIENT_TOKEN=pubac01816ac2c0ab0ee753e75c83cc5946' 'DD_AGENT_HOST=localhost' 'DD_LOGS_ENABLED=true' > /etc/environment

export DD_ENV=dev
export DD_SERVICE=ps-vue-ls
export DD_VERSION=0.0.3
export DD_PS_APP_ID=199c6858-0b0b-4b4a-a64f-f0fc03b3cce2
export DD_PS_CLIENT_TOKEN=pubac01816ac2c0ab0ee753e75c83cc5946
export DD_AGENT_HOST=localhost


sudo wget http://nginx.org/keys/nginx_signing.key
sudo apt-key add nginx_signing.key
echo 'deb http://nginx.org/packages/ubuntu focal nginx\ndeb-src http://nginx.org/packages/ubuntu focal nginx' >> /etc/apt/sources.list
sudo apt-get update
sudo apt-get install nginx --assume-yes
sudo systemctl start nginx.service

get_latest_release() {
  wget -qO- "https://api.github.com/repos/$1/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/';
}
# NGINX_VERSION=1.17.3
NGINX_VERSION=1.24.0
OPENTRACING_NGINX_VERSION="$(get_latest_release opentracing-contrib/nginx-opentracing)"
DD_OPENTRACING_CPP_VERSION=v1.3.6
# Install Nginx plugin for OpenTracing
wget https://github.com/opentracing-contrib/nginx-opentracing/releases/download/${OPENTRACING_NGINX_VERSION}/linux-amd64-nginx-${NGINX_VERSION}-ot16-ngx_http_module.so.tgz
sudo tar zxf linux-amd64-nginx-${NGINX_VERSION}-ot16-ngx_http_module.so.tgz -C /usr/lib/nginx/modules

wget https://github.com/DataDog/dd-opentracing-cpp/releases/download/${DD_OPENTRACING_CPP_VERSION}/linux-amd64-libdd_opentracing_plugin.so.gz
gunzip linux-amd64-libdd_opentracing_plugin.so.gz -c > /usr/local/lib/libdd_opentracing_plugin.so

sudo systemctl start nginx.service
git clone https://github.com/cahillsf/funvue-classic.git -b main /home/ubuntu/funvue-classic
rm -rf /etc/nginx/conf.d/default.conf
cp -RT /home/ubuntu/funvue-classic/dist /usr/share/nginx/html
cp /home/ubuntu/funvue-classic/nginx.conf /etc/nginx/conf.d
cp /home/ubuntu/funvue-classic/apm/nginx.conf /etc/nginx
cp /home/ubuntu/funvue-classic/dd/conf.yaml /etc/datadog-agent/conf.d/nginx.d/
cp /home/ubuntu/funvue-classic/dd/datadog.yaml /etc/datadog-agent/
cp /home/ubuntu/funvue-classic/dd/nginx /etc/logrotate.d/
chmod +x /home/ubuntu/funvue-classic/docker_init/docker_entrypoint_apm.sh /home/ubuntu/funvue-classic/docker_init/generate_env_config.sh /home/ubuntu/funvue-classic/docker_init//generate_dd_config.sh
/bin/sh /home/ubuntu/funvue-classic/docker_init/docker_entrypoint_apm.sh
find /var/log/nginx -type d -exec chmod 755 {} \;
find /var/log/nginx -type f -exec chmod 644 {} \;
sudo printf '%s\n' 'api_key: <DD_API_KEY>' >> /etc/datadog-agent/datadog.yaml
sudo service datadog-agent restart
sudo systemctl restart nginx