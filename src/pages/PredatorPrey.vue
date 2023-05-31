<template>
 <div class="singleColGrid">
    <top-toolbar></top-toolbar>
    <div class="header"> 
      <h1>C++ Predator-Prey Simulation </h1>
            <p>
              This was an exercise I completed to demonstrate understanding of object oriented programming in C++ for NYU Tandon's online bridge course.  I used XCode as an IDE to generate this 20 x 20 array where the predators are X's and the prey are o's.  View the source code <a href="https://github.com/cahillsf/doodlebug" target="_blank">here.</a><br/><br/>The world is initialized randomly at the beginning of the program with 5 predators and 100 prey.  Each time the user hits "Enter" a segment of time passes, and the animals on the board will act according to the following rules:
            </p>
            <p id="rules">
                The goal for this project is to create a simple two-dimensional predator-prey simulation. In this simulation the prey are ants and the predators are doodlebugs. These critters live in a world composed of a 20 x 20 grid of cells. Only one critter may occupy a cell at a time. The grid is enclosed, so a critter is not allowed to move off the edges of the world. Time is simulated in time steps. Each critter performs some action every time step. <br/><br/>

                The <b>ants</b> behave according to the following model: <br/><br/><i>Move:</i> Every time step, randomly try to move up, down, left, or right. If the neighboring cell in the selected direction is occupied or would move the ant off the grid, then the ant stays in the current cell.<br/><br/>

                <i>Breed:</i> If an ant survives for three time steps, then at the end of the time step (that is; after moving) the ant will breed. This is simulated by creat-ing a new ant in an adjacent (up, down, left, or right) cell that is empty. If there is no empty cell available, then no breeding occurs. Once an off-spring is produced, an ant cannot produce an offspring until three more time steps have elapsed.<br/><br/>

                The <b>doodlebugs</b> behave according to the following model:<br/><br/> <i>Move:</i> Every time step, if there is an adjacent ant (up, down, left, or right), then the doodlebug will move to that cell and eat the ant. Otherwise, the doodlebug moves according to the same rules as the ant. Note that a doodlebug cannot eat other doodlebugs.<br/><br/>

                <i>Breed:</i> If a doodlebug survives for eight time steps, then at the end of the time step it will spawn off a new doodlebug in the same manner as the ant.<br/><br/>

                <i>Starve:</i> If a doodlebug has not eaten an ant within the last three time steps, then at the end of the third time step it will starve and die. The doodlebug should then be removed from the grid of cells.<br/><br/>

                During one turn, all the doodlebugs should move before the ants do.<br/><br/>

                Write a program to implement this simulation and draw the world using ASCII characters of "o" for an ant and "X" for a doodlebug or "-" for an empty space. Create a class named Organism that encapsulates basic data common to both ants and doodlebugs. This class should have a virtual function named move that is defined in the derived classes of Ant and Doodlebug. You may need additional data structures to keep track of which critters have moved.<br/><br/>

                Initialize the world with 5 doodlebugs and 100 ants. After each time step, prompt the user to press Enter to move to the next time step. You should see a cyclical pattern between the population of predators and prey, although random perturbations may lead to the elimination of one or both species.

            </p>
            <p>
                Check out the images below for screen captures of the program in action:
            </p>
    </div>
   <div class="imgDiv">
        <div>
            <img src="@/assets/doodlebug_assets/shot1.png" alt="picture of predator-prey simulation 1" class="screencap">
        </div>
        <div>
            <img src="@/assets/doodlebug_assets/shot2.png" alt="picture of predator-prey simulation 1" class="screencap">
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
};
</script>

<style scoped>
p {
  text-align: left;
  margin: 3%;
}
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

#rules{
	font-size: 0.8em;
}

.imgDiv{
  grid-template-columns: 1fr;
  grid-row: 3;
  text-align: center;
	display: grid;
	grid-template-columns: 1fr 1fr;
	grid-column-gap: 20px;
	margin-left: 10px;
	margin-right: 13px;
}

.screencap{
	width: 250px;
	height:auto;
}
</style>
