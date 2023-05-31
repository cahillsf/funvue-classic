<template>
 <div class="singleColGrid">
    <top-toolbar></top-toolbar>
    <div class="header">
      <h1 >Three.js Example</h1>
      <h3 class ="paragraph">This is a page I put together while exploring the <span><a href="https://threejs.org/" target="_blank">three.js library</a></span>.  
          I modeled the tooth using <span><a href="https://www.meshmixer.com/" target="_blank">Meshmixer</a></span>, a very cool free 3-D modeling software, then loaded it as a object into my Three scene.  Select the icon below to check out the page, then click the front tooth to add another row of teeth to this floating phalanx!  </h3>
    </div>
    <div class="bigtoothdiv">
      <div id="imgdiv">
          <a @click="navigateToPage('/threescene')" id="bigtootha" target="_blank">
              <img src="@/assets/texttooth.png" id="bigtooth" alt="big tooth"/>
          </a>
      </div>
    </div>
    <bottom-bar v-bind:style="bottomBarProps"></bottom-bar>
  </div>
  
    
</template>

<script>
import TopToolbar from '../components/TopToolbar.vue';
import BottomBar from '../components/BottomBar.vue';
export default {
  name: 'ToothPage',
  components: {
    TopToolbar,
    BottomBar
  },
  data () {
    return {
      msg: 'Welcome to Your Vue.js App',
      bottomBarProps: {
        'grid-column': '1',
        'background-image': 'linear-gradient(to top, #c4d4e0 0%,#6e9db3 100%)',
        'display': 'grid',
        'grid-row': 4,
      },
    }
  },
  methods: {
    doSomething() {
      this.msg= 'another page hahahahahahahaha!';
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>


.header {
  grid-row: 2;
}

.paragraph {
  text-align: left;
  margin: 3%;
}
.bigtoothdiv{
	text-align: center;
	display: grid;
	grid-template-columns: 1fr 1fr 1fr;
  grid-row: 3;
}

#bigtooth{
	position: relative;
	text-align: center;
	width: 100%;  
	margin-top: 0;
}

#imgdiv{
	grid-column: 2/3;
}


</style>
