<template>
  <div id="container"> 
    <div id="arrow-div" @click="$router.back()">
      <img id="left-arrow" src="/assets/leftarrow.png"/>
    </div>
    <div id="loading" :class="{ 'displayoff': loaded }">
      <div class="spinner">Loading...</div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import * as THREE from 'three'
import { OBJLoader } from 'three/examples/jsm/loaders/OBJLoader.js'

let camera, scene, renderer, zStart, xStart, xStop, xInc, count, raycaster, mouse

zStart = 30
xStart = -30
xStop = 30
xInc = 30

const loaded = ref(false)

const animate = () => {
  requestAnimationFrame(animate)
  const sceneChild = scene.children
  sceneChild[0].rotation.x += 0.01
  sceneChild[0].rotation.y += 0.01
  renderer.render(scene, camera)
  if(count % 6 == 0) {
    camera.position.z += 100
  }
}

const onDocumentMouseDown = (event) => {
  event.preventDefault()
  mouse.x = (event.clientX / renderer.domElement.clientWidth) * 2 - 1
  mouse.y = - (event.clientY / renderer.domElement.clientHeight) * 2 + 1
  
  raycaster.setFromCamera(mouse, camera)
  const sceneChild = scene.children
  const group = sceneChild[0]
  let first = group.getObjectByName("father")
  
  const meshObjects = [first]
  const intersects = raycaster.intersectObjects(meshObjects, true)
  
  if (intersects.length > 0) {
    addTeeth(xStart, xStop, xInc, zStart, scene)
    xStart -= 30
    xStop += 30
    zStart += 30
    count++
  }
}

const onWindowResize = () => {
  camera.aspect = window.innerWidth / window.innerHeight
  camera.updateProjectionMatrix()
  renderer.setSize(window.innerWidth, window.innerHeight)
}

const init = () => {
  let container = document.getElementById('container')
  scene = new THREE.Scene()
  camera = new THREE.PerspectiveCamera(70, window.innerWidth / window.innerHeight, 1, 500)
  camera.position.z = 200
  
  renderer = new THREE.WebGLRenderer({ alpha: true })
  renderer.setClearColor("#86DDE3")
  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setPixelRatio(window.devicePixelRatio)
  
  container.appendChild(renderer.domElement)
  window.addEventListener('resize', onWindowResize, false)
  
  const loader = new OBJLoader()
  loader.load('/yourMesh.obj', (obj) => {
    obj.traverse(function (child) {
      if(child instanceof THREE.Mesh) {
        child.material = new THREE.MeshMatcapMaterial()
      }
    })
    let myGroup = new THREE.Group()
    obj.name = "father"
    obj.position.set(0, 0, 0)
    myGroup.add(obj)
    scene.add(myGroup)
    animate()
    loaded.value = true
    alert("Click the front tooth to increase the size of the flying-v")
  })
  
  raycaster = new THREE.Raycaster()
  mouse = new THREE.Vector2()
  
  document.addEventListener('mousedown', onDocumentMouseDown, false)
}

const addTeeth = (xBegin, xEnd, xPlus, z, sc) => {
  const sceneChild = sc.children
  const group = sceneChild[0]
  let first = group.getObjectByName("father")
  for(let i = xBegin; i <= xEnd; i += xPlus) {
    let newTooth = first.clone()
    newTooth.position.x = i
    newTooth.position.z = z
    group.add(newTooth)
  }
}

onMounted(() => {
  init()
})

onUnmounted(() => {
  window.removeEventListener('resize', onWindowResize, false)
  document.removeEventListener('mousedown', onDocumentMouseDown, false)
})
</script>

<style scoped>
#arrow-div {
  cursor: pointer;
}

#arrow-div:hover #left-arrow {
  width: 28px;
}

#left-arrow {
  position: absolute;
  top: 10px;
  left: 10px;
  width: 25px;
  height: auto;
}

#loading {
  position: absolute;
  top: 50%;
  left: 47.5%;
  color: white;
}

.displayoff {
  display: none;
}

.spinner {
  font-size: 24px;
  font-weight: bold;
}

.container {
  background: #86DDE3;
}
</style>

