<template>
 <div class="singleColGridCv">
    <top-toolbar></top-toolbar>
    <div id="pdfMain">
        <!-- <div id="pageSwitchWrapper">
            <div id="selectionWrapper">
                <button :disabled="page <= 1" @click="page--">❮</button>

                {{ page }} / {{ pageCount }}

                <button :disabled="page >= pageCount" @click="page++">❯</button>
            </div>
        </div> -->
        <div id="pdfWrapper">
                <vue-pdf-embed class="pdfCanvas" ref="pdfRef" :source="source1" :page="page" />
            </div>
    </div>
    <bottom-bar v-bind:style="bottomBarProps"></bottom-bar>
  </div>
  
    
</template>

<script>
import TopToolbar from '../components/TopToolbar.vue';
import BottomBar from '../components/BottomBar.vue';
import VuePdfEmbed from 'vue-pdf-embed/dist/vue2-pdf-embed';
export default {
  name: 'ToothPage',
  components: {
    TopToolbar,
    BottomBar,
    VuePdfEmbed
  },
  data () {
    return {
      page: 1,
      // pageCount: 2,
      source1: 'static/cahillsf_cv_f.pdf',
    //   source1: 'https://raw.githubusercontent.com/mozilla/pdf.js/ba2edeae/examples/learning/helloworld.pdf',
      msg: 'Welcome to Your Vue.js App',
      bottomBarProps: {
        'grid-column': '1',
        'background-image': 'linear-gradient(to top, #c4d4e0 0%,#6e9db3 100%)',
        'display': 'grid',
        'grid-row': 3,
      },
    }
  },
  methods: {
      handleDocumentRender() {
    //   this.isLoading = false
        this.pageCount = this.$refs.pdfRef.pageCount;
        console.log(this.$refs.pdfRef.pageCount);
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

#pageSwitchWrapper {
    background-color: #555;
    width: 100%;
    color: #ddd;
    padding: 8px 0px 5px 0px;
    position: relative;
    display: grid;
}


#pdfMain {
    grid-row: 2;
    background-color: #ccc;
    /* justify-self: center; */
    width:100%;
    display: grid;
}

#pdfWrapper {
    width: 80vw;
    padding-top: 10px;
    justify-self: center;
}

.singleColGridCv{
  position: relative;
  display: grid;
  grid-template-columns: 1fr;
  grid-template-rows: 60px 1fr 60px;
  /* row-gap: 60px; */
}

</style>
