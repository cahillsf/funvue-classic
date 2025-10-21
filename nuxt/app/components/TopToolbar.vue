<template>
  <div class="toolbarSticky" role="banner">
    <div id="logo-name" @click="onHomePage ? $router.go() : navigateTo('/')">
      <img id="logo" src="/assets/initials.png"/>
      <ul>
        <li>Stephen Cahill</li>
        <li>Developer</li>
      </ul>
    </div>
    <div class="spacer"></div>

    <div id="button-wrapper" class="menu-button-in" :class="{ 'menu-button-invisible': smallScreenOnLoad, 'menu-button-out': buttonAnimate }">
      <button 
        v-for="page in pages" 
        :key="page._id" 
        class="menu-button" 
        :class="{ 'selected': page.selected }" 
        @click="page.selected ? null : navigateTo(page.path)"
      >
        {{ page.title }}
      </button>
    </div>
  
    <div id="icon-div" class="icon-animate-in" :class="{ 'icon-div-invisible': largeScreenOnLoad, 'icon-animate-out': iconAnimate}">
      <button 
        id="hamburger" 
        class="hamburger--vortex"  
        :class="{ 'is-active': activeBurger}" 
        @click="showDropdown" 
        ref="sandwichIcon" 
        type="button"
      >
        <span class="hamburger-box">
          <span class="hamburger-inner"></span>
        </span>
      </button>
      <div v-if="dropDisplayed" id="nav-dropdown">
        <nav>
          <a 
            v-for="page in pages" 
            :key="page._id" 
            @click="page.selected ? null : navigateTo(page.path)"
          >
            {{ page.title }}
          </a>
        </nav>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import debounce from 'debounce'

const router = useRouter()
const route = useRoute()

const dropDisplayed = ref(false)
const largeScreenOnLoad = ref(false)
const smallScreenOnLoad = ref(false)
const firstTime = ref(true)
const iconAnimate = ref(null)
const buttonAnimate = ref(null)
const activeBurger = ref(false)
const sandwichIcon = ref(null)

const pages = ref([
  { '_id': 0, 'title': 'Home', 'path': '/', 'selected': false },
  { '_id': 1, 'title': 'About Me', 'path': '/aboutme', 'selected': false },
  { '_id': 2, 'title': 'CV', 'path': '/cv', 'selected': false }
])

const onHomePage = computed(() => route.path === '/')

const setCurPageClass = () => {
  pages.value.forEach(page => {
    page.selected = route.path === page.path
  })
}

const showDropdown = () => {
  activeBurger.value = !dropDisplayed.value
  dropDisplayed.value = !dropDisplayed.value
}

const triggerTrackResize = debounce(() => {
  if (window.innerWidth >= 670) {
    if (dropDisplayed.value && sandwichIcon.value) {
      sandwichIcon.value.click()
    }
    if (smallScreenOnLoad.value && firstTime.value) {
      smallScreenOnLoad.value = false
      firstTime.value = false
      buttonAnimate.value = true
      iconAnimate.value = true
    }
  } else if (largeScreenOnLoad.value && firstTime.value) {
    largeScreenOnLoad.value = false
    firstTime.value = false
    iconAnimate.value = true
    buttonAnimate.value = true
  }
}, 200)

onMounted(() => {
  if (window.innerWidth > 670) {
    largeScreenOnLoad.value = true
  } else {
    smallScreenOnLoad.value = true
  }
  
  window.addEventListener("resize", triggerTrackResize)
  setCurPageClass()
})

onUnmounted(() => {
  window.removeEventListener("resize", triggerTrackResize)
})
</script>

<style scoped>
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

#logo-name li {
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

#button-wrapper {
  display: grid;
  grid-column-gap: 20px;
  position: relative;
  margin-right: 2%;
}

/* Hide buttons on small screens by default */
@media only screen and (max-width: 670px) {
  #button-wrapper {
    display: none;
  }
}

/* Show buttons on large screens by default */
@media only screen and (min-width: 670px) {
  #button-wrapper {
    display: grid;
  }
}

.menu-button {
  grid-row: 1;
  width: 100%;
  padding: 8px 16px;
  background-color: rgba(255, 255, 255, 0.2);
  color: white;
  border: 1px solid rgba(255, 255, 255, 0.3);
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
}

.menu-button:hover {
  background-color: rgba(255, 255, 255, 0.3);
  transform: translateY(-1px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}

.selected {
  background-color: rgba(255, 255, 255, 0.95);
  color: #2d6a4f;
  font-weight: 600;
  border-color: rgba(255, 255, 255, 0.95);
}

.spacer {
  flex: 1;
}

.toolbarSticky {
  position: fixed;
  z-index: 1;
  left: 0;
  right: 0;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: space-around;
  background: linear-gradient(135deg, #52b788 0%, #1b4332 100%);
  color: white;
  font-weight: 600;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

#icon-div {
  display: grid;
  position: absolute;
  right: -10vw;
  background-color: transparent;
  margin: 0;
}

/* Hide burger on large screens by default */
@media only screen and (min-width: 670px) {
  #icon-div {
    display: none;
  }
}

/* Show burger on small screens by default */
@media only screen and (max-width: 670px) {
  #icon-div {
    display: grid;
  }
}

.icon-div-invisible {
  display: grid;
  right: -10vw;
  position: relative;
  left: -700vw;
  opacity: 0;
  width: 0;
}

.menu-button-invisible {
  left: -700vw;
  position: relative;
  opacity: 0;
  width: 0;
  height: 100%;
}

#nav-dropdown {
  position: absolute;
  background: linear-gradient(135deg, #52b788 0%, #1b4332 100%);
  right: 0px;
  top: 55px;
  border-radius: 8px;
  padding: 10px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
}

#nav-dropdown nav {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

#nav-dropdown a {
  color: white;
  text-decoration: none;
  padding: 8px 16px;
  cursor: pointer;
}

#nav-dropdown a:hover {
  background-color: rgba(255, 255, 255, 0.1);
  border-radius: 4px;
}

@media only screen and (min-width: 670px) {
  .icon-animate-out {
    animation-duration: 1s; 
    animation-name: icon-animate-out;
    animation-fill-mode: forwards;
  }
  .menu-button-in {
    animation-duration: 0.7s;
    animation-name: buttons-animate-in;
    animation-fill-mode: forwards;
  }
}

@media only screen and (max-width: 670px) {
  .menu-button-out {
    animation-duration: 0.7s;
    animation-name: buttons-animate-out;
    animation-fill-mode: forwards;
  }

  .icon-animate-in {
    animation-duration: 1s;
    animation-name: icon-animate-in;
    animation-fill-mode: forwards;
  }
}

@keyframes icon-animate-out {
  0% {
    right: 0;
    position: relative
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
    position: relative;
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
  overflow: visible;
}

.hamburger:hover {
  opacity: 0.7;
}

.hamburger.is-active:hover {
  opacity: 0.7;
}

.hamburger.is-active .hamburger-inner,
.hamburger.is-active .hamburger-inner::before,
.hamburger.is-active .hamburger-inner::after {
  background-color: #000;
}

.hamburger-box {
  width: 40px;
  height: 24px;
  display: inline-block;
  position: relative;
}

.hamburger-inner {
  display: block;
  top: 50%;
  margin-top: -2px;
}

.hamburger-inner, .hamburger-inner::before, .hamburger-inner::after {
  width: 40px;
  height: 4px;
  background-color: #000;
  border-radius: 4px;
  position: absolute;
  transition-property: transform;
  transition-duration: 0.15s;
  transition-timing-function: ease;
}

.hamburger-inner::before, .hamburger-inner::after {
  content: "";
  display: block;
}

.hamburger-inner::before {
  top: -10px;
}

.hamburger-inner::after {
  bottom: -10px;
}

.hamburger--vortex .hamburger-inner {
  transition-duration: 0.2s;
  transition-timing-function: cubic-bezier(0.19, 1, 0.22, 1);
}

.hamburger--vortex .hamburger-inner::before, .hamburger--vortex .hamburger-inner::after {
  transition-duration: 0s;
  transition-delay: 0.1s;
  transition-timing-function: linear;
}

.hamburger--vortex .hamburger-inner::before {
  transition-property: top, opacity;
}

.hamburger--vortex .hamburger-inner::after {
  transition-property: bottom, transform;
}

.hamburger--vortex.is-active .hamburger-inner {
  transform: rotate(765deg);
  transition-timing-function: cubic-bezier(0.19, 1, 0.22, 1);
}

.hamburger--vortex.is-active .hamburger-inner::before, .hamburger--vortex.is-active .hamburger-inner::after {
  transition-delay: 0s;
}

.hamburger--vortex.is-active .hamburger-inner::before {
  top: 0;
  opacity: 0;
}

.hamburger--vortex.is-active .hamburger-inner::after {
  bottom: 0;
  transform: rotate(90deg);
}
</style>

