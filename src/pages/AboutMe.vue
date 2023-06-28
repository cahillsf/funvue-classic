<template>
 <div class="singleColGrid">
    <top-toolbar></top-toolbar>
    <div id="mainDiv"> 
        <h1>Stephen Cahill</h1>
        <img id="portrait" alt="photo of me" src="@/assets/aboutme_assets/portrait-redux.jpg" />
        <p>
            Thanks for visiting my website!  I hope you're enjoying your stay; if you're interested in the source code you can take a look <span><a href="https://github.com/cahillsf/funvue-classic" target="_blank">here</a></span>.  I enjoy building websites, learning new technologies and improving my programming skills.  As a solutions engineer, I find one of the most exciting aspects of the role is creating virtual environments for testing expected behaviors and reproducing issues.  Currently, my primary focus is furthering my understanding of the Go programming language and working towards attaining the <span><a href="https://aws.amazon.com/certification/certified-developer-associate/?ch=sec&sec=rmg&d=1" target="_blank">AWS Developer Associate certification</a></span>.
        </p>
        <p>
            My road to working in IT several years ago when I began pursuing an intellectual curiosity: computer science and programming. Starting with a few MOOC's and intro Python courses, my desire to learn took hold of me and I enrolled in the <span><a href="https://engineering.nyu.edu/academics/programs/nyu-tandon-bridge" target="_blank">NYU Tandon online bridge program</a></span> which teaches the fundamentals of computer science.  The program is designed for people with limited STEM backgrounds to gather the skills needed to pursue a Master's degree in computer science. This intensive six-month curriculum covered programming, discrete mathematics and networking. Following the NYU bridge program, I began pursuit of a <span><a href="https://seidenberg.pace.edu/computer-science-ms" target="_blank">Master's degree in computer science at Pace University</a></span> which I completed in May 2021. 
        </p>
        <p>
          Prior to working in tech, I spent eight years working as a restaurant manager in the dynamic and thriving dining scence of New York City. Over the course of that time I've managed a diverse range of businesses from quickly growing fast-casual chains such as Dos Toros and Luke's Lobster, to destination pizzerias like Roberta's in Bushwick. Along the way I accumulated the skills to handle full HR admininstrative responsibilities for staff sizes ranging from five to fifty employees, develop insightful profit and loss business analyses,  juggle vendor relationships, and take ownership over all the nuances embedded in operating successful, high grossing, fast-paced businesses.
        </p>
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
        'grid-row': 3,
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

#mainDiv {

  padding-bottom: 5vh;
  grid-row: 2;
}

#mainDiv p {
  margin: 3%;
}

#portrait{
	position: relative;
	width: 200px;
	height: auto;
  top: 0;
	float: left;
	border-radius: 25px;
	/* margin-top: 15px; */
	margin-left: 3%;
	margin-right: 15px;
	margin-bottom: 0;
	box-shadow: 8px 8px 5px grey;
	
}

.imgDiv{
  display: grid;
  grid-template-columns: 1fr;
  grid-row: 3;
  text-align: center;
	grid-column-gap: 20px;
	margin-left: 10px;
	margin-right: 13px;
}
</style>
