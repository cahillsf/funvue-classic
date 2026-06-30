<template>
  <div class="canvasGrid">
    <div id="arrow-div" @click="$router.back()">
      <img id="left-arrow" src="/assets/leftarrow.png"/>
    </div>
    <canvas id="c"></canvas>
  </div>
</template>

<script setup>
import { onMounted, onUnmounted } from 'vue'

let canvas, ctx

const draw = () => {
  console.log("drawing")
  ctx.clearRect(0, 0, screen.availWidth, screen.availHeight)
  ctx.lineWidth = 0.003 * screen.availWidth
  let xInc = (3.5 * (0.003 * screen.availWidth))
  ctx.strokeStyle = 'black'
  ctx.beginPath()
  let xLoc = -30
  let firstLineYStop = 0.5 * screen.availHeight
  let secondLineYStop = 0.88 * screen.availHeight
  let thirdLineYStop = screen.availHeight
  let cp1 = { x: (xLoc + 20), y: (0.35 * firstLineYStop)}
  let cp2 = { x: (xLoc - 125), y: (0.7 * firstLineYStop)}
  let cp3 = { x: (xLoc + 90), y: (0.75 * secondLineYStop)}
  let cp4 = { x: (xLoc - 150), y: (0.9 * secondLineYStop)}
  let cp5 = { x: (xLoc + 45), y: (0.93 * thirdLineYStop)}
  let cp6 = { x: (xLoc + 50), y: (thirdLineYStop)}
  
  let reachedEnd = false
  while(reachedEnd == false) {
    addCurveSubPath(cp1, cp2, xLoc, 0, xLoc, firstLineYStop, ctx)
    addCurveSubPath(cp3, cp4, xLoc, firstLineYStop, (xLoc - 40), secondLineYStop, ctx)
    addCurveSubPath(cp5, cp6, (xLoc - 40), secondLineYStop, (xLoc - 10), thirdLineYStop, ctx)
    xLoc += xInc
    cp1.x += xInc
    cp2.x += xInc
    cp3.x += xInc
    cp4.x += xInc
    cp5.x += xInc
    cp6.x += xInc
    if(xLoc > screen.availWidth + 80) {
      reachedEnd = true
    }
  }
  ctx.stroke()
}

const addCurveSubPath = (point1, point2, startX, startY, endX, endY, ctx) => {
  ctx.moveTo(startX, startY)
  ctx.bezierCurveTo(point1.x, point1.y, point2.x, point2.y, endX, endY)
}

const init = () => {
  window.requestAnimationFrame(draw)
}

onMounted(() => {
  canvas = document.getElementById("c")
  canvas.width = screen.availWidth
  canvas.height = screen.availHeight
  ctx = canvas.getContext('2d')
  init()
  window.addEventListener("resize", draw)
})

onUnmounted(() => {
  window.removeEventListener("resize", draw)
})
</script>

<style scoped>
#c {
  grid-row: 1;
  width: initial;
  margin-bottom: initial;
  box-shadow: initial;
}

#arrow-div {
  cursor: pointer;
  background-color: #1c5080;
}

#left-arrow {
  background-color: #1c5080;
  border-radius: 40%;
}

#arrow-div:hover #left-arrow {
  width: 33px;
}

#left-arrow {
  position: absolute;
  top: 10px;
  left: 10px;
  width: 30px;
  height: auto;
}

.canvasGrid {
  position: relative;
  display: grid;
  grid-template-columns: 1fr;
  grid-template-rows: 1fr;
}
</style>

