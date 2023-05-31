<template>
 <div class="singleColGrid">
    <top-toolbar></top-toolbar>
    <div class="header">
      <h1>Graph Algorithms with NetworkX</h1>
      <p>
          This was a project covering graph theory and graph algorithms.  I created a undirected weighted graph of 29 nodes in a csv file, then imported the csv into a networkx graph and produced a visualization using matplotlib.  I then implemented various algorithms including depth first search traversal, breadth first search traversal, Kruskal's minimum spanning tree algorithm, and more.  Check out the Jupyter notebook (as a webpage) <a @click="navigateToPage('/networkjupyternb')"><span>here</span></a>. 

      </p>
    </div>
    <div id="networkdiv">
        <div id="networkimgdiv">
            <img id="networkimg" src="@/assets/network_assets/network_pic.png" alt="network pic" />
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
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

.bottomBarProps {
    /* grid-column: 1; */
    background-image: linear-gradient(to top, #c4d4e0 0%,#6e9db3 100%);
    /* grid-column: 1 / 3; */
    display: grid;
}

.header {
  grid-row: 2;
}



#networkdiv{
  grid-row: 3;
	display:grid;
	grid-template-columns: 20% 60% 20%;
}
#networkimgdiv{
    grid-column:2;
}


</style>
