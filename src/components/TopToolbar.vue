<template>
    <div class="toolbarSticky" role="banner">
        <div id="logo-name" v-on="onHomePage ? { click: () => this.$router.go() } : { click: () => navigateToPage('/') }">
          <img id="logo" src="@/assets/initials.png"/>
          <ul>
							<li>Stephen Cahill</li>
							<li>Developer</li>
          </ul>
        </div>
        <div class="spacer"></div>

        <div id="button-wrapper" class="menu-button-in" v-bind:class="{ 'menu-button-invisible':  smallScreenOnLoad, 'menu-button-out':buttonAnimate }">
          <vk-button size="small" class="menu-button" v-bind:class="{ 'selected':  page.selected }" type="primary" v-for="page in pages" v-bind:key="page.id" v-on="page.selected ? {} : { click: () => navigateToPage(page.path) }">
            {{ page.title }}
          </vk-button>
          <!-- <vk-button size="small" class="menu-button" @click="testEnv()">
            TEST
          </vk-button> -->
        </div>
      
        <div id="icon-div" class="icon-animate-in" v-bind:class="{ 'icon-div-invisible': largeScreenOnLoad, 'icon-animate-out': iconAnimate}">
          <button id="hamburger" class="hamburger--vortex"  v-bind:class="{ 'is-active': activeBurger}" @click="showDropdown" ref="sandwichIcon" type="button">
            <span class="hamburger-box">
              <span class="hamburger-inner"></span>
            </span>
          </button>
          <vk-drop animation="slide-top-small" position="top-right" mode="click" ref="dropMenu">
            <vk-navbar-nav-dropdown-nav align="right" navbar-aligned="true" id="nav-dropdown">
              <!-- TO DO: add in routing once I have additional pages -->
              <vk-nav-item id="nav-item" v-for="page in pages" v-bind:key="page.id" :title="page.title" v-on="page.selected ? {} : { click: () => navigateToPage(page.path) }"></vk-nav-item>
            </vk-navbar-nav-dropdown-nav>
          </vk-drop>
        </div>
    </div>

</template>

<script>
import { debounce } from "debounce";
import '@vuikit/theme';
import { Button, ButtonLink } from '../../node_modules/vuikit/lib/button';
import { Icon, IconButton } from '../../node_modules/vuikit/lib/icon';
import { IconMenu } from '@vuikit/icons';
import { Drop } from '../../node_modules/vuikit/lib/drop';
import { NavbarNavItem, NavbarNavDropdownNav } from '../../node_modules/vuikit/lib/navbar';
export default {
  name: 'TopToolbar',
  components: {
      VkButton: Button,
      VkButtonLink: ButtonLink,
      VkMenu: IconMenu,
      VkIcon: Icon,
      VkIconButton: IconButton,
      VkDrop: Drop,
      VkNavItem: NavbarNavItem, 
      VkNavbarNavDropdownNav: NavbarNavDropdownNav
  },
  data () {
    return {
      msg: 'Talk Tungsten 2 Me',
      dropDisplayed: false,
      largeScreenOnLoad: false,
      smallScreenOnLoad: false,
      firstTime: true,
      iconAnimate: null,
      buttonAnimate: null,
      onHomePage: true,
      activeBurger: false,
      pages: [
        {
          '_id': 0,
          'title': 'Home',
          'path':'/',
        },
        {
          '_id': 1,
          'title': 'About Me',
          'path':'/aboutme'
        },
        {
          '_id': 2,
          'title': 'CV',
          'path':'/CV'
        },
        // {
        //   '_id': 3,
        //   'title': 'Contact Me',
        //   'path':'/contactme'
        // },
      ]
    }
  },
  mounted(){

    if(window.innerWidth > 670){
      this.largeScreenOnLoad = true;
      return;
    }
    this.smallScreenOnLoad = true;

  },
  created(){
    window.addEventListener("resize", debounce(this.triggerTrackResize, 200));
    this.setCurPageClass();
  },
  destroyed(){
    window.removeEventListener("resize", this.trackResize);
  },
  methods: {
    setCurPageClass() {
      let pageKeys = Object.keys(this.pages);
      pageKeys.forEach(key => {
        let curPage = Object.values(this.pages).find(el => el._id === parseInt(key));
        let jsonCurPage = JSON.parse(JSON.stringify(curPage));
        if (this.$router.currentRoute.path == jsonCurPage.path){
          curPage['selected'] = true;
        }
      })
      this.onHomePage = (this.$router.currentRoute.path == '/')? true : false;
    },
    doSomething() {
      this.msg= 'TopToolbar!;'
    },
    showDropdown(){
      this.activeBurger = (this.dropDisplayed ? false : true)
      this.dropDisplayed = (this.dropDisplayed ? false : true);
    },
    triggerTrackResize(){
      if(window.innerWidth >= 670){
        if(this.dropDisplayed){
          this.$refs.sandwichIcon.click();
        }
        if(this.smallScreenOnLoad && this.firstTime){
          this.smallScreenOnLoad = false;
          this.firstTime = false;
          this.buttonAnimate = true;
          this.iconAnimate = true;
        }
      }
      else if(this.largeScreenOnLoad && this.firstTime){
        this.largeScreenOnLoad = false;
        this.firstTime = false;
        this.iconAnimate = true;
        this.buttonAnimate = true;
      }
    },
    testEnv() {
      console.log(window.VUE_APP_DD_APP_ID);
      console.log(window.VUE_APP_BUILD);
    }
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.uk-navbar-dropdown-nav > li > a {
  color: white;
}

.uk-navbar-dropdown-nav > li:hover > a {
  color: black;
}

#hamburger {
  background-color: transparent;
  margin: 0;
  border: 0;
  cursor: pointer;
}
#logo-name {
  margin-left: 10px;
  font-size: 18px;
  display: grid;
}
#logo-name * {
  grid-row: 1;
}

#logo-name:hover {
  cursor: pointer;
}

#logo-name ul {
  list-style-type: none;
  padding-left: 5px;
}

#logo-name li{
	text-align: left;
	margin: 0;
	padding: 0;
}

#logo {
  width: 50px;
	height: 50px;
	position: relative;
  top: 21px;
}

#menu-icon2{
  cursor: pointer;
  position: relative;
  width: 30px;
  height: 30px;
  padding: 2px;
  right: 3vw;
}


#button-wrapper {
  display: grid;
  grid-column-gap: 20px;
  position: relative;
  margin-right: 2%;
}

.selected {
  background-color: #486988;
  color: #fff;
}
.spacer {
  flex: 1;
}

.menu-button{
  grid-row: 1;
  width: 100%;
}

.toolbarSticky {
  /* grid-row: 1; */
  position: fixed;
  z-index: 1;
  left: 0;
  right: 0;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: space-around;
  background-image: linear-gradient(to top, #c4d4e0 0%,#6e9db3 100%);
  color: white;
  font-weight: 600;
}

.toolbar {
  /* grid-row: 1; */
  position: absolute;
  left: 0;
  right: 0;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: space-around;
  background-image: linear-gradient(to top, #c4d4e0 0%,#6e9db3 100%);
  color: white;
  font-weight: 600;
}

.icon-div{
  display: grid;
  position: absolute;
  right: -10vw;
  background-color: transparent;
  margin: 0;
}

.icon-div-invisible{
  display: grid;
  /* position: absolute; */
  right: -10vw;
  /* width: 0; */
  position: relative;
  left: -700vw;
  opacity: 0;
  width: 0;
}

.menu-button-invisible{
  left: -700vw;
  position: relative;
  opacity: 0;
  width: 0;
  height: 100%;
}


@media only screen and (min-width: 670px){
  .icon-animate-out{
    animation-duration: 1s; 
    animation-name: icon-animate-out;
    animation-fill-mode: forwards;
  }
  .menu-button-in{
    animation-duration: 0.7s;
    animation-name: buttons-animate-in;
    animation-fill-mode: forwards;
  }
  
}

@media only screen and (max-width: 670px){
  .menu-button-out{
    animation-duration: 0.7s;
    animation-name: buttons-animate-out;
    animation-fill-mode: forwards;
  }

  .icon-animate-in {
    animation-duration: 1s;
    animation-name: icon-animate-in;
    animation-fill-mode: forwards;
  }

  #nav-dropdown{
    position: absolute;
    background: #6e9db3;
    right: 0px;
    top: 55px;
  }

}
@keyframes icon-animate-out {
    0% {
      right: 0;
      position:relative
    }
    100% {
      position: relative;
      left: -700vw;
      opacity: 0;
      width: 0;
    }
}

@keyframes icon-animate-in {
    from {
      right: -10vw;
      position:relative;
    }

    to {
      right: 0;
      position: relative;
    }
}

@keyframes buttons-animate-in {
    100% {
      margin-right: 2%;
      position: relative;
    }

    80% {
      left: -10vw;
      position: relative;
      opacity: 0.9;
    }
    
    40% {
      left: -80vw;
      position: relative;
      opacity: 0.4;
    }

    /* 50% {
      left: -10vw;
      position: relative;
      opacity: 0.9;
    }
    
    10% {
      left: -50vw;
      position: relative;
      opacity: 0.5; 
    }*/
    0% {
      left: -100vw;
      position: relative;
      opacity: 0;
    }
}

@keyframes buttons-animate-out {
    0% {
      margin-right: 2%;
      position: relative;
    }

    10% { 
      left: -50vw;
      position: relative;
      opacity: 0.9;
    }
    
    90% {
      left: -500vw;
      position: relative;
      opacity: 0.5;
    }

    100% {
      left: -700vw;
      position: relative;
      opacity: 0;
      width: 0;
    }
}
.hamburger {
  padding: 15px 15px;
  display: inline-block;
  cursor: pointer;
  transition-property: opacity, filter;
  transition-duration: 0.15s;
  transition-timing-function: linear;
  font: inherit;
  color: inherit;
  text-transform: none;
  background-color: transparent;
  border: 0;
  margin: 0;
  overflow: visible; }
  .hamburger:hover {
    opacity: 0.7; }
  .hamburger.is-active:hover {
    opacity: 0.7; }
  .hamburger.is-active .hamburger-inner,
  .hamburger.is-active .hamburger-inner::before,
  .hamburger.is-active .hamburger-inner::after {
    background-color: #000; }

.hamburger-box {
  width: 40px;
  height: 24px;
  display: inline-block;
  position: relative; }

.hamburger-inner {
  display: block;
  top: 50%;
  margin-top: -2px; }
  .hamburger-inner, .hamburger-inner::before, .hamburger-inner::after {
    width: 40px;
    height: 4px;
    background-color: #000;
    border-radius: 4px;
    position: absolute;
    transition-property: transform;
    transition-duration: 0.15s;
    transition-timing-function: ease; }
  .hamburger-inner::before, .hamburger-inner::after {
    content: "";
    display: block; }
  .hamburger-inner::before {
    top: -10px; }
  .hamburger-inner::after {
    bottom: -10px; }

.hamburger--vortex .hamburger-inner {
  transition-duration: 0.2s;
  transition-timing-function: cubic-bezier(0.19, 1, 0.22, 1); }
  .hamburger--vortex .hamburger-inner::before, .hamburger--vortex .hamburger-inner::after {
    transition-duration: 0s;
    transition-delay: 0.1s;
    transition-timing-function: linear; }
  .hamburger--vortex .hamburger-inner::before {
    transition-property: top, opacity; }
  .hamburger--vortex .hamburger-inner::after {
    transition-property: bottom, transform; }

.hamburger--vortex.is-active .hamburger-inner {
  transform: rotate(765deg);
  transition-timing-function: cubic-bezier(0.19, 1, 0.22, 1); }
  .hamburger--vortex.is-active .hamburger-inner::before, .hamburger--vortex.is-active .hamburger-inner::after {
    transition-delay: 0s; }
  .hamburger--vortex.is-active .hamburger-inner::before {
    top: 0;
    opacity: 0; }
  .hamburger--vortex.is-active .hamburger-inner::after {
    bottom: 0;
    transform: rotate(90deg); }

</style>
