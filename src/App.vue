<template>
  <div id="app">
    <!--img src="./assets/logo.png"-->
    <router-view/>
  </div>
</template>

<script>
import AOS from '../node_modules/aos/dist/aos.js';
import { datadogRum } from '@datadog/browser-rum';
export default {
  name: 'App',
  beforeCreate() {
    AOS.init();
  },
  created(){
    //TODO: reenable when site is live

    datadogRum.init({
          applicationId: window.VUE_APP_DD_APP_ID,
          clientToken: window.VUE_APP_DD_CLIENT_TOKEN,
          site: 'datadoghq.com',
          service:'vue-app',
          env: 'dev',
          // Specify a version number to identify the deployed version of your application in Datadog 
          version: '1.0.0',
          sampleRate: 100,
          premiumSampleRate: 100,
          trackInteractions: true,
          allowedTracingOrigins:["http://localhost:8000", /https:\/\/.*\.stephencahill\.net/]
        });
  }
}
</script>

<style>
@import '../node_modules/aos/dist/aos.css';
@font-face {
  font-family: "Playfair";
  src: url(assets/fonts/PlayfairDisplay-Regular.ttf) format ("truetype");
  font-weight: normal;
  font-style: normal;
}

#app {
  /* font-family: 'Avenir', Helvetica, Arial, sans-serif; */
  font-family: "Playfair", Times, serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 0px;
  position: relative;
}

.homeGrid{
  position: relative;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  row-gap: 5%;
}

.singleColGrid{
  position: relative;
  display: grid;
  grid-template-columns: 1fr;
  row-gap: 60px;
}

canvas {
  width: 90vw;
  margin-bottom: 8px;
  box-shadow: 0 2px 8px 4px rgba(0, 0, 0, 0.1);
}

p {
  text-align: left;
  margin: 3%;
}

div.grecaptcha-badge { 
  visibility: hidden; 
}
</style>
