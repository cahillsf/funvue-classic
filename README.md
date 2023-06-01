# vue-project

> A Vue.js project

## Build Setup

``` bash
# install dependencies
npm install

# serve with hot reload at localhost:8080
npm run dev

# build for production with minification
npm run build

# build for production and view the bundle analyzer report
npm run build --report
```

For a detailed explanation on how things work, check out the [guide](http://vuejs-templates.github.io/webpack/) and [docs for vue-loader](http://vuejs.github.io/vue-loader).


### use lightsail ubuntu lts 20.04 release -- startup.sh is the user-data script

#### to-do
- pin tracing versions?
- nginx host tracing docs: https://docs.datadoghq.com/tracing/trace_collection/proxy_setup/?tab=nginx#nginx-with-opentracing-module
- nginx on Ubuntu LTS docs: https://www.nginx.com/blog/setting-up-nginx/
- need to import the GH repo in the VM, build the app, then use dockerfile-apm to customize the nginx behavior
- need to setup DNS, LB after confirming the app is running as expected