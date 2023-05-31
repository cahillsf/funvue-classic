// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'

Vue.config.productionTip = false
Vue.prototype.$hostname = (window.VUE_APP_BUILD == "kubernetes") ? '/api' : 'http://localhost:8000/api'


Vue.mixin({
  methods: {
    navigateToPage: function (route) {
      console.log("pushing " + route)
      this.$router.push({ path: route });
    },
    backOnePage: function () {
      this.$router.go(-1);
    },
  },
})
/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})


