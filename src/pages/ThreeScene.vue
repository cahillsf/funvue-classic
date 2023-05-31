<template>
    <div id="container" > 
        <div id="arrow-div" @click="backOnePage">
            <img id="left-arrow" src="@/assets/leftarrow.png"/>
        </div>
        <div id="loading" v-bind:class="{ 'displayoff':  loaded }">
            <vk-spinner ratio=2.0></vk-spinner>
        </div>
        <!-- <h1> Three Scene </h1> -->
        <!-- <canvas v-for="" v-bind:key="card.id"></canvas> -->
    </div>
</template>

<script>
import * as THREE from 'three';
// import * as OBJLoader from '@/assets/js/obj.js';
import { OBJLoader } from 'three/examples/jsm/loaders/OBJLoader.js';
import { Spinner } from '../../node_modules/vuikit/lib/spinner';
var camera, scene, renderer, zStart, xStart, xStop, xInc, count, raycaster, mouse;
zStart = 30;
xStart = -30;
xStop = 30;
xInc = 30;

export default {
  name: 'ThreeScene',
  components: {
      VkSpinner: Spinner
  },
  data () {
    return {
        progress:'0',
        loaded: false,
    }
  },
  mounted() {
    this.init();
  },
  destroyed() {
    window.removeEventListener( 'resize', this.onWindowResize, false );
    document.removeEventListener('mousedown', this.onDocumentMouseDown, false);
  },
  methods: {

    animate() {
        requestAnimationFrame( this.animate );
        var sceneChild = scene.children;
        sceneChild[0].rotation.x += 0.01;
        sceneChild[0].rotation.y += 0.01;
        renderer.render( scene, camera );
        if(count % 6 == 0){
            camera.position.z += 100;
        }
    },
    onDocumentMouseDown(event) {
        event.preventDefault();
        mouse.x = (event.clientX / renderer.domElement.clientWidth) * 2 - 1;
        mouse.y =  - (event.clientY / renderer.domElement.clientHeight) * 2 + 1;
        // console.log("mouse x is " + mouse.x +" mouse y is " + mouse.y);
        raycaster.setFromCamera(mouse, camera);
        var sceneChild = scene.children;
        var group = sceneChild[0];
        let first = group.getObjectByName("father");
        // console.log(first);

        var meshObjects = [first]; // three.js objects with click handlers we are interested in
        //console.log("first pos x " + first.position.x + " first pos y " + first.position.y);
        var intersects = raycaster.intersectObjects(meshObjects, true);
        // console.log("intersects length is  " + intersects.length);

        if (intersects.length > 0) {
            // console.log(intersects[0]);
            // console.log("name is " + intersects[0].uuid)
            // console.log(intersects[1]);
            this.addTeeth(xStart, xStop, xInc, zStart, scene);
            xStart -= 30;
            xStop += 30;
            zStart += 30;
            count++;
        }

    },
    onWindowResize(){
        camera.aspect = window.innerWidth / window.innerHeight;
        camera.updateProjectionMatrix();
        renderer.setSize( window.innerWidth, window.innerHeight );
    },
    init() {
        let container = document.getElementById('container');
        scene = new THREE.Scene();
        camera = new THREE.PerspectiveCamera( 70 , window.innerWidth / window.innerHeight, 1, 500);
        camera.position.z = 200;
        
        renderer = new THREE.WebGLRenderer( {alpha: true} );
        renderer.setClearColor("#86DDE3");
        renderer.setSize( window.innerWidth, window.innerHeight );
        renderer.setPixelRatio(window.devicePixelRatio);
        
        
        container.appendChild(renderer.domElement);
        window.addEventListener( 'resize', this.onWindowResize, false );
        var material = new THREE.MeshMatcapMaterial();
        
        const manager = new THREE.LoadingManager();
        // console.log(manager);
        var loader = new OBJLoader();
        loader.load('static/yourMesh.obj', (obj)=> {       
             obj.traverse( function (child) {
                // console.log("traversing")
                if(child instanceof THREE.Mesh ){
                    // console.log("CHILD IS")
                    child.material = new THREE.MeshMatcapMaterial();
                }
                // console.log(child);
                } );
                let myGroup = new THREE.Group();
                obj.name = "father";
                obj.position.set(0, 0, 0);
                myGroup.add(obj);
                scene.add(myGroup); 
                // console.log("added to myGroup ")
                // console.log(myGroup)
                this.animate();
                this.loaded = true;
                alert("Click the front tooth to increase the size of the flying-v");

            },
            function ( xhr ) {
                this.progress = xhr.loaded / xhr.total * 100
                console.log( ( xhr.loaded / xhr.total * 100 ) + '% loaded' );
            },
            // called when loading has errors
            function ( error ) {
                console.log( 'An error happened' );
            }
        );

        raycaster = new THREE.Raycaster();
        mouse = new THREE.Vector2();

        document.addEventListener('mousedown', this.onDocumentMouseDown, false);
    },

    addTeeth(xBegin, xEnd, xPlus, z, sc) {
        var sceneChild = sc.children;
        var group = sceneChild[0];
        let first = group.getObjectByName("father");
        for(let i = xBegin; i <= xEnd; i+=xPlus){
            let newTooth = first.clone();
            newTooth.position.x = i;
            //newTooth.position.y = y;
            newTooth.position.z = z;
            group.add(newTooth);
        }
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
#arrow-div {
    cursor: pointer;
}

#arrow-div:hover #left-arrow{
    width: 28px;
}
#left-arrow {
    position: absolute;
    top: 10px;
    left: 10px;
    width: 25px;
    height: auto;
}
#app{
    margin-top: 0px;
}

#loading{
    position:absolute;
    top: 50%;
    left: 47.5%;
}

.displayoff{
    display: none;
}

.container{
    background: #86DDE3;
}
</style>
