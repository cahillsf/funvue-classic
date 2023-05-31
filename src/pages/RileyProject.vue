<template>
 <div class="singleColGrid">
    <top-toolbar></top-toolbar>
    <div class="header"> 
      <h1 >Bridget Riley Canvas Element Project</h1>
      <p class ="paragraph">
          For this project I selected a work by English painter Bridget Riley to replicate using a Canvas element.  The work I selected is called "Fall" and was completed in 1963 and is shown below. The <a @click="navigateToPage('/rileycanvas')" ><span>first part</span></a> of the project is a static webpage with a full page canvas element inspired by this painting.  The second part is a mobile page that requests access to your mobile device's location services and the image reflects the motion of the device.  The mobile site is still a work in progress, the video below demonstrates the page in action.  
      </p>
    </div>
    <div class="rileydiv">
            <div>
                <img src="@/assets/riley_assets/original.jpg" id="riley_original" alt="Bridget Riley 'Fall' Painting"/>
            </div>
            <div>
                <video id="canvas_vid" controls>
                    <source src="@/assets/riley_assets/animation.mp4" type="video/mp4">
                    Your browser does not support the video tag.
                </video>
            </div>
    </div>   
    <!-- <div id="spacer"></div> -->
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
    
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

.bottomBarProps {
    grid-column: 1;
    background-image: linear-gradient(to top, #c4d4e0 0%,#6e9db3 100%);
    /* grid-column: 1 / 3; */
    display: grid;
}

.header {
  grid-row: 2;
}


#canvas_vid {
	width: 250px;
	height: auto; 	
}

.rileydiv{
  grid-row: 3;
	text-align: center;
	display: grid;
	grid-template-columns: 1fr 1fr;
	grid-column-gap: 20px;
	margin-left: 10px;
	margin-right: 13px;
    
}

</style>
