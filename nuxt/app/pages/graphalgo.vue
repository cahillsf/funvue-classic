<template>
  <div class="singleColGrid">
    <TopToolbar />
    <div class="header">
      <h1>Graph Algorithms with NetworkX</h1>
      <p>
        This was a project covering graph theory and graph algorithms. I created a undirected weighted graph of 29 nodes in a csv file, then imported the csv into a networkx graph and produced a visualization using matplotlib. I then implemented various algorithms including depth first search traversal, breadth first search traversal, Kruskal's minimum spanning tree algorithm, and more. Check out the Jupyter notebook (as a webpage) <a @click="navigateTo('/networkjupyternb')"><span>here</span></a>.
      </p>
    </div>
    <div id="networkdiv">
      <div id="networkimgdiv">
        <img id="networkimg" src="/assets/network_assets/network_pic.png" alt="network pic" />
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

#networkdiv {
  grid-row: 3;
  display: grid;
  grid-template-columns: 20% 60% 20%;
}

#networkimgdiv {
  grid-column: 2;
}
</style>

