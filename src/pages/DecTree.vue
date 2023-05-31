<template>
 <div class="singleColGrid">
    <top-toolbar></top-toolbar>
    <div class="header">
      <h1>Algorithmic Analysis with Decision Trees</h1>
      <p>
          This is a really fun project I completed for an algorithms class as an introduction to using decision tree classifiers to perform algorithmic analysis.  The <span><a href="https://archive.ics.uci.edu/ml/datasets/census+income" target="_blank">data set</a></span>  is composed of almost 50,000 entries from the 1994 census with 15 columns of attributes from the UC Irvine Machine Learning Repository   Firstly, I used pandas to import the data sets for basic preliminary explanatory data analysis and matplotlib to visualize aspects of this analysis.<br/><br/>  I then imported the scikit-learn module and used its processing functionality to encode any string values as numeric values.  Now that the data was formatted properly, I fit two classifiers with the training data set using different splitting criterion (Gini index and information gain) to predict the income attribute and plot them using graphviz and IPython. Finally, I used scikit-learn's estimator to calculate the accuracy of each calssifier on the test data set.  Check out the Jupyter notebook (as a webpage) <a @click="navigateToPage('/jupyternb')"><span>here</span></a>.
      </p>
    </div>
    <div class="display one">
			<h2>Using Entropy Splitting Criterion</h2>
			<div id="imgdiv1">
				<img id="dectree1" src="@/assets/dectree_assets/dectree_entropy.png" alt="decision tree 1" />
			</div>
	</div>
    <div class="display two">
        <h2>Using Gini Index Splitting Criterion</h2>
        <div id="imgdiv2">
            <img id="dectree2" src="@/assets/dectree_assets/dectree_gini.png" alt="decision tree 2" />
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
        'grid-row': 5,
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
    /* grid-column: 1; */
    background-image: linear-gradient(to top, #c4d4e0 0%,#6e9db3 100%);
    /* grid-column: 1 / 3; */
    display: grid;
}

.header {
  grid-row: 2;
}

.display{
	justify-self: center;
	position: relative;
	text-align: center;
}

.one {
    grid-row: 3;
}

.two {
    grid-row: 4;
}
</style>
