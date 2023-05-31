<template>
 <div class="singleColGrid">
     <div id="test">
         <p> testing</p>
     </div>
    <div id="arrow-div" @click="navigateToPage('/rileyproject')">
        <img id="left-arrow" src="@/assets/leftarrow.png"/>
    </div>
    <canvas id="c"></canvas>
</div>
</template>

<script>
import TopToolbar from '../components/TopToolbar.vue';
import BottomBar from '../components/BottomBar.vue';
var canvas, ctx;

export default {
  name: 'ToothPage',
  components: {
    TopToolbar,
    BottomBar
  },
  data () {
    return {
      msg: 'Welcome to Your Vue.js App',
    }
  },
  mounted() {
    canvas = document.getElementById("c");
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    // console.log(window.innerWidth);
    ctx = canvas.getContext('2d');

  },
  methods: {
    init(){
 			window.requestAnimationFrame( this.draw);
 	},
    draw(){
        var coordsArray = currCoords();
        window.addEventListener('devicemotion', returnCoords, true);
        function returnCoords(event){
            var currTime = new Date();
            var currSecs = currTime.getSeconds();
            var x = event.accelerationIncludingGravity.x;
            var y = event.accelerationIncludingGravity.y;
            var z = event.accelerationIncludingGravity.z;
            var newX = smoothX(x);
            console.log("x is " + x + " smooth x is " + newX);
            //console.log(currSecs);

            //if(currTime % 2 == 0){
            ctx.clearRect(0,0, window.innerWidth, window.innerHeight);
            ctx.lineWidth = 0.003 * window.innerWidth;
            var xInc = (3.5 * (0.003 * window.innerWidth));
            ctx.strokeStyle = 'black'; 
            ctx.beginPath();
            var xLoc = -30;
            var firstLineYStop = 0.5 * window.innerHeight;
            var secondLineYStop = 0.88 * window.innerHeight;
            var thirdLineYStop = window.innerHeight + 5;
            var cp1 = { x: (xLoc + 20 + (newX*200)), y: (0.35 * firstLineYStop)};
            var cp2 = { x: (xLoc - 125 - (newX*200)), y: (0.7 * firstLineYStop)};
            var cp3 = { x: (xLoc + 90 + (newX*75)), y: (0.75 * secondLineYStop)};
            var cp4 = { x: (xLoc - 150 - (newX*75)), y: (0.9 * secondLineYStop)};
            var cp5 = { x: (xLoc + 45 + (newX*24)), y: (0.93 * thirdLineYStop)};
            var cp6 = { x: (xLoc + 50 + (newX*24)), y: (0.98 * thirdLineYStop)};
            var reachedEnd = false;
            currCoords();
            while(reachedEnd == false){

                addCurveSubPath(cp1, cp2, xLoc, 0, xLoc, firstLineYStop, ctx);
                addCurveSubPath(cp3, cp4, xLoc, firstLineYStop, (xLoc - 40), secondLineYStop, ctx);
                addCurveSubPath(cp5, cp6, (xLoc - 40), secondLineYStop, (xLoc - 10), thirdLineYStop, ctx);
                
                xLoc += xInc;
                cp1.x += xInc;
                cp2.x += xInc;
                cp3.x += xInc;
                cp4.x += xInc;
                cp5.x += xInc;
                cp6.x += xInc;
                
                if(xLoc > window.innerWidth + 80){
                    reachedEnd = true;
                }
            }
            
            ctx.stroke();
            
        }
        window.requestAnimationFrame(draw);

    },
    addCurveSubPath(point1, point2, startX, startY, endX, endY, ctx){
        ctx.moveTo(startX, startY);
        ctx.bezierCurveTo(point1.x, point1.y, point2.x, point2.y, endX, endY);
 	},
	addLineSubPath(x, ctx) {
        ctx.moveTo(x, 0);
        ctx.lineTo(x, window.innerHeight);
    }
    
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
#c {
    grid-row: 1;
}


#arrow-div {
    cursor: pointer;
    background-color: #1c5080;
}
#left-arrow {
    background-color: #1c5080;
    border-radius: 40%;
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

</style>
