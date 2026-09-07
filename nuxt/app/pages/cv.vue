<template>
  <div class="singleColGridCv">
    <TopToolbar />
    <div id="pdfMain">
      <div id="pdfWrapper">
        <iframe src="/cahillsf_cv_f.pdf"></iframe>
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
  'grid-row': 3
})
</script>

<style scoped>
#pdfMain {
  grid-row: 2;
  background-color: transparent; /* Lets the global #app pattern show through */
  width: 100%;
  display: flex;
  justify-content: center;
  padding: 4vh 0; /* Breathing room top and bottom */
}

#pdfWrapper {
  width: 85vw;
  max-width: 1000px; /* Prevents it from getting too wide on huge monitors */
  height: 80vh; /* Responsive height */
  border-radius: 16px;
  overflow: hidden; /* Clips the iframe to the rounded corners */
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1), 0 1px 3px rgba(0, 0, 0, 0.05); /* Soft, realistic floating shadow */
  background: white;
}

iframe {
  width: 100%;
  height: 100%;
  border: none;
}

.singleColGridCv {
  position: relative;
  display: grid;
  grid-template-columns: 1fr;
  grid-template-rows: 60px 1fr 60px;
}
</style>

