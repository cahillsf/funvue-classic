<template>
 <div class="iframeGrid">
    <div id="arrow-div" @click="backOnePage">
        <img id="left-arrow" src="@/assets/leftarrow.png"/>
    </div>
    <div id="iframe">
        <iframe :height="pageHeight" :width="pageWidth" src="static/scahill_project1.html"></iframe>
    </div>
 </div>
</template>

<script>
import TopToolbar from '../components/TopToolbar.vue';
import BottomBar from '../components/BottomBar.vue';
export default {
  name: 'JupyterNb',
  components: {
    TopToolbar,
    BottomBar
  },
  data () {
    return {
      msg: 'Welcome to Your Vue.js App',
      pageHeight: null,
      pageWidth: null
    }
  },
  mounted(){
      console.log(window.innerHeight)
      this.pageHeight = window.innerHeight - 17;
      this.pageWidth = window.innerWidth - 17;
      window.addEventListener("resize", this.resizeIframe);
  },
  destroyed(){
    window.removeEventListener("resize", this.resizeIframe);
  },
  methods: {
      resizeIframe(){
        this.pageHeight = window.innerHeight - 17;
        this.pageWidth = window.innerWidth - 17;
      }
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

.iframeGrid{
  position: relative;
  display: grid;
  grid-template-columns: 1fr;
}

#arrow-div {
    cursor: pointer;
}

#arrow-div:hover #left-arrow{
    width: 33px;
}
#left-arrow {
    position: absolute;
    top: 10px;
    left: 10px;
    width: 30px;
    height: auto;
}
#iframe{
    grid-row: 1
}

</style>
