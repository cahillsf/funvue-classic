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

    <div id="button-wrapper">
      <button 
        v-for="page in pages" 
        :key="page._id" 
        class="menu-button" 
        :class="{ 'selected': page.selected }" 
        @click="page.selected ? null : navigateTo(page.path)"
      >
        {{ page.title }}
      </button>
      <div class="social-divider"></div>
      <a href="https://github.com/cahillsf" target="_blank" class="menu-button social-btn" aria-label="GitHub">
        <img src="/assets/ghIcon.png" alt="GitHub"/>
      </a>
      <a href="https://www.linkedin.com/in/cahillsf/" target="_blank" class="menu-button social-btn" aria-label="LinkedIn">
        <img src="/assets/lin.png" alt="LinkedIn"/>
      </a>
      <div class="email-btn-container">
        <button 
          class="menu-button social-btn" 
          :class="{ 'copied-success': copied }" 
          aria-label="Copy email address" 
          title="Copy email to clipboard" 
          type="button"
          @click="copyEmail"
        >
          <svg v-if="copied" class="check-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="20 6 9 17 4 12"></polyline>
          </svg>
          <img v-else src="/assets/email.png" alt="Email"/>
        </button>
        <transition name="fade">
          <div v-if="copied" class="copied-tooltip">Copied to clipboard!</div>
        </transition>
      </div>
    </div>
  
    <div id="icon-div">
      <button 
        id="hamburger" 
        class="hamburger--vortex"  
        :class="{ 'is-active': activeBurger}" 
        @click="showDropdown" 
        ref="sandwichIcon" 
        type="button"
        aria-label="Toggle navigation menu"
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
            class="dropdown-link"
            :class="{ 'selected': page.selected }"
            @click="handleNavClick(page.path, page.selected)"
          >
            {{ page.title }}
          </a>
          <div class="dropdown-divider"></div>
          <div class="dropdown-social-row">
            <a href="https://github.com/cahillsf" target="_blank" class="menu-button social-btn" aria-label="GitHub" @click="showDropdown">
              <img src="/assets/ghIcon.png" alt="GitHub"/>
            </a>
            <a href="https://www.linkedin.com/in/cahillsf/" target="_blank" class="menu-button social-btn" aria-label="LinkedIn" @click="showDropdown">
              <img src="/assets/lin.png" alt="LinkedIn"/>
            </a>
            <div class="email-btn-container">
              <button 
                class="menu-button social-btn" 
                :class="{ 'copied-success': copied }" 
                aria-label="Copy email address" 
                title="Copy email to clipboard" 
                type="button"
                @click="copyEmail"
              >
                <svg v-if="copied" class="check-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                  <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
                <img v-else src="/assets/email.png" alt="Email"/>
              </button>
              <transition name="fade">
                <div v-if="copied" class="copied-tooltip dropdown-tooltip">Copied to clipboard!</div>
              </transition>
            </div>
          </div>
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
const activeBurger = ref(false)
const copied = ref(false)
let copyTimeout = null

const copyEmail = async () => {
  const email = 'cahillsf9@gmail.com'
  try {
    if (navigator.clipboard && window.isSecureContext) {
      await navigator.clipboard.writeText(email)
    } else {
      const textArea = document.createElement('textarea')
      textArea.value = email
      textArea.style.position = 'fixed'
      textArea.style.left = '-999999px'
      textArea.style.top = '-999999px'
      document.body.appendChild(textArea)
      textArea.focus()
      textArea.select()
      document.execCommand('copy')
      textArea.remove()
    }
    copied.value = true
    if (copyTimeout) clearTimeout(copyTimeout)
    copyTimeout = setTimeout(() => {
      copied.value = false
    }, 2200)
  } catch (err) {
    console.error('Failed to copy email: ', err)
  }
}

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

const handleNavClick = (path, selected) => {
  showDropdown()
  if (!selected) {
    navigateTo(path)
  }
}

const triggerTrackResize = debounce(() => {
  if (window.innerWidth >= 670 && dropDisplayed.value) {
    dropDisplayed.value = false
    activeBurger.value = false
  }
}, 200)

onMounted(() => {
  window.addEventListener("resize", triggerTrackResize)
  setCurPageClass()
})

onUnmounted(() => {
  window.removeEventListener("resize", triggerTrackResize)
  if (copyTimeout) clearTimeout(copyTimeout)
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
  display: flex;
  align-items: center;
  gap: 12px;
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
    display: flex;
  }
}

.social-divider {
  width: 1px;
  height: 24px;
  background-color: rgba(255, 255, 255, 0.4);
  margin: 0 4px;
}

.menu-button.social-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0;
  width: 36px;
  height: 36px;
  border-radius: 50%;
  text-decoration: none;
}

.menu-button.social-btn img {
  height: 18px;
  filter: brightness(0) invert(1);
}

.email-btn-container {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: center;
}

.menu-button.copied-success {
  background-color: rgba(255, 255, 255, 0.95);
  border-color: rgba(255, 255, 255, 0.95);
  transform: translateY(-2px) scale(1.05);
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
}

.check-icon {
  stroke: #1b4332;
}

.copied-tooltip {
  position: absolute;
  top: calc(100% + 10px);
  right: 0;
  background-color: #1b4332;
  color: white;
  padding: 6px 12px;
  border-radius: 8px;
  font-size: 12px;
  font-weight: 500;
  white-space: nowrap;
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.3);
  border: 1px solid rgba(255, 255, 255, 0.2);
  pointer-events: none;
  z-index: 100;
}

.copied-tooltip::before {
  content: '';
  position: absolute;
  bottom: 100%;
  right: 12px;
  border-width: 5px;
  border-style: solid;
  border-color: transparent transparent #1b4332 transparent;
}

.dropdown-tooltip {
  top: calc(100% + 8px);
  right: 0;
}

.dropdown-tooltip::before {
  right: 12px;
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease, transform 0.2s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
  transform: translateY(-4px);
}

.menu-button {
  padding: 8px 16px;
  background-color: rgba(255, 255, 255, 0.2);
  color: white;
  border: 1px solid rgba(255, 255, 255, 0.3);
  border-radius: 24px; /* Fully pill-shaped */
  cursor: pointer;
  font-size: 14px;
  transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  backdrop-filter: blur(10px);
}

.menu-button:hover {
  background-color: rgba(255, 255, 255, 0.3);
  transform: translateY(-2px) scale(1.05);
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
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
  z-index: 1000;
  top: 0;
  left: 0;
  right: 0;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
  box-sizing: border-box;
  background: linear-gradient(135deg, #52b788 0%, #1b4332 100%);
  color: white;
  font-weight: 600;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

#icon-div {
  position: relative;
  display: flex;
  align-items: center;
  background-color: transparent;
  margin: 0;
}

/* Hide burger on large screens */
@media only screen and (min-width: 671px) {
  #icon-div {
    display: none;
  }
}

/* Show burger on small screens */
@media only screen and (max-width: 670px) {
  #icon-div {
    display: flex;
  }
}

#nav-dropdown {
  position: absolute;
  background: linear-gradient(135deg, #52b788 0%, #1b4332 100%);
  right: 0;
  top: 50px;
  border-radius: 8px;
  padding: 10px;
  min-width: 150px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
}

#nav-dropdown nav {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

#nav-dropdown .dropdown-link {
  color: white;
  text-decoration: none;
  padding: 8px 16px;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s ease;
  font-size: 14px;
}

#nav-dropdown .dropdown-link:hover {
  background-color: rgba(255, 255, 255, 0.15);
}

#nav-dropdown .dropdown-link.selected {
  background-color: rgba(255, 255, 255, 0.25);
  font-weight: 600;
}

.dropdown-divider {
  width: 100%;
  height: 1px;
  background-color: rgba(255, 255, 255, 0.25);
  margin: 4px 0;
}

.dropdown-social-row {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  padding: 4px 0 2px 0;
}

#nav-dropdown .social-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0;
  width: 36px;
  height: 36px;
  border-radius: 50%;
  text-decoration: none;
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

