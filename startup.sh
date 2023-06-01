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
NGINX_VERSION=1.17.3
OPENTRACING_NGINX_VERSION="$(get_latest_release opentracing-contrib/nginx-opentracing)"
DD_OPENTRACING_CPP_VERSION=v1.3.6
# Install Nginx plugin for OpenTracing
wget https://github.com/opentracing-contrib/nginx-opentracing/releases/download/${OPENTRACING_NGINX_VERSION}/linux-amd64-nginx-${NGINX_VERSION}-ot16-ngx_http_module.so.tgz
sudo tar zxf linux-amd64-nginx-${NGINX_VERSION}-ot16-ngx_http_module.so.tgz -C /usr/lib/nginx/modules

wget https://github.com/DataDog/dd-opentracing-cpp/releases/download/${DD_OPENTRACING_CPP_VERSION}/linux-amd64-libdd_opentracing_plugin.so.gz
gunzip linux-amd64-libdd_opentracing_plugin.so.gz -c > /usr/local/lib/libdd_opentracing_plugin.so

su - ubuntu -c "git clone https://github.com/cahillsf/funvue-classic.git -b main /home/ubuntu/funvue-classic"
su - ubuntu -c "cd home/ubuntu/funvue-classic"
