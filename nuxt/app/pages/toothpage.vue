<template>
  <div class="singleColGrid">
    <TopToolbar />
    <div class="header">
      <h1>Three.js Example</h1>
      <h3 class="paragraph">
        This is a page I put together while exploring the <span><a href="https://threejs.org/" target="_blank">three.js library</a></span>. 
        I modeled the tooth using <span><a href="https://www.meshmixer.com/" target="_blank">Meshmixer</a></span>, a very cool free 3-D modeling software, then loaded it as a object into my Three scene. Select the icon below to check out the page, then click the front tooth to add another row of teeth to this floating phalanx!
      </h3>
    </div>
    <div class="bigtoothdiv">
      <div id="imgdiv">
        <a @click="navigateTo('/threescene')" id="bigtootha">
          <img src="/assets/texttooth.png" id="bigtooth" alt="big tooth"/>
        </a>
      </div>
    </div>
    <BottomBar :style="bottomBarProps" />
  </div>
</template>

<script setup>
import { ref } from 'vue'

const bottomBarProps = ref({
  'grid-column': '1',
  'background': 'linear-gradient(135deg, #52b788 0%, #1b4332 100%)',
  'display': 'grid',
  'grid-row': 4
})
</script>

<style scoped>
.header {
  grid-row: 2;
}

.paragraph {
  text-align: left;
  margin: 3%;
}

.bigtoothdiv {
  text-align: center;
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  grid-row: 3;
}

#bigtooth {
  position: relative;
  text-align: center;
  width: 100%;  
  margin-top: 0;
}

#imgdiv {
  grid-column: 2/3;
}

#bigtootha {
  cursor: pointer;
}
</style>

