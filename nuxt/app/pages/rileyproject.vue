<template>
  <div class="singleColGrid">
    <TopToolbar />
    <div class="header"> 
      <h1>Bridget Riley Canvas Element Project</h1>
      <p class="paragraph">
        For this project I selected a work by English painter Bridget Riley to replicate using a Canvas element. The work I selected is called "Fall" and was completed in 1963 and is shown below. The <a @click="navigateTo('/rileycanvas')"><span>first part</span></a> of the project is a static webpage with a full page canvas element inspired by this painting. The second part is a mobile page that requests access to your mobile device's location services and the image reflects the motion of the device. The mobile site is still a work in progress, the video below demonstrates the page in action.  
      </p>
    </div>
    <div class="rileydiv">
      <div>
        <img src="/assets/riley_assets/original.jpg" id="riley_original" alt="Bridget Riley 'Fall' Painting"/>
      </div>
      <div>
        <video id="canvas_vid" controls>
          <source src="/assets/riley_assets/animation.mp4" type="video/mp4">
          Your browser does not support the video tag.
        </video>
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

#canvas_vid {
  width: 250px;
  height: auto;
}

.rileydiv {
  grid-row: 3;
  text-align: center;
  display: grid;
  grid-template-columns: 1fr 1fr;
  grid-column-gap: 20px;
  margin-left: 10px;
  margin-right: 13px;
}
</style>

