<template>
  <div class="singleColGridCv">
    <TopToolbar />
    <div id="pdfMain">
      <div id="pdfWrapper">
        <iframe 
          src="/cahillsf_cv_f.pdf" 
          width="100%" 
          height="800px"
          style="border: none;"
        ></iframe>
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
  background-color: #ccc;
  width: 100%;
  display: grid;
}

#pdfWrapper {
  width: 80vw;
  padding-top: 10px;
  justify-self: center;
}

.singleColGridCv {
  position: relative;
  display: grid;
  grid-template-columns: 1fr;
  grid-template-rows: 60px 1fr 60px;
}
</style>

