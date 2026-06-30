<template>
  <div class="iframeGrid">
    <div id="arrow-div" @click="$router.back()">
      <img id="left-arrow" src="/assets/leftarrow.png"/>
    </div>
    <div id="iframe">
      <iframe :height="pageHeight" :width="pageWidth" src="/scahill_project2.html"></iframe>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

const pageHeight = ref(null)
const pageWidth = ref(null)

const resizeIframe = () => {
  pageHeight.value = window.innerHeight - 17
  pageWidth.value = window.innerWidth - 17
}

onMounted(() => {
  pageHeight.value = window.innerHeight - 17
  pageWidth.value = window.innerWidth - 17
  window.addEventListener("resize", resizeIframe)
})

onUnmounted(() => {
  window.removeEventListener("resize", resizeIframe)
})
</script>

<style scoped>
.iframeGrid {
  position: relative;
  display: grid;
  grid-template-columns: 1fr;
}

#arrow-div {
  cursor: pointer;
}

#arrow-div:hover #left-arrow {
  width: 33px;
}

#left-arrow {
  position: absolute;
  top: 10px;
  left: 10px;
  width: 30px;
  height: auto;
}

#iframe {
  grid-row: 1
}
</style>

