import Vue from 'vue'
import Router from 'vue-router'
import HomePage from '@/pages/HomePage'
import ToothPage from '@/pages/ToothPage'
import ThreeScene from '@/pages/ThreeScene'
import RileyProject from '@/pages/RileyProject'
import RileyCanvas from '@/pages/RileyCanvas'
import DecTree from '@/pages/DecTree'
import JupyterNb from '@/pages/JupyterNb'
import NetworkGraph from '@/pages/NetworkGraph'
import NetworkJupyterNb from '@/pages/NetworkJupyterNb'
import PredatorPrey from '@/pages/PredatorPrey'
import AboutMe from '@/pages/AboutMe'
import CV from '@/pages/CV'
import ContactMe from '@/pages/ContactMe'

Vue.use(Router)

export default new Router({
  mode: 'history',
  hash: false,
  routes: [
    {
      path: '/',
      name: 'HomePage',
      component: HomePage
    },
    {
      path: '/toothpage',
      name: 'ToothPage',
      component: ToothPage
    },
    {
      path: '/threescene',
      name: 'ThreeScene',
      component: ThreeScene
    },
    {
      path: '/rileyproject',
      name: 'RileyProject',
      component: RileyProject
    },
    {
      path: '/rileycanvas',
      name: 'RileyCanvas',
      component: RileyCanvas
    },
    {
      path: '/dectree',
      name: 'DecTree',
      component: DecTree
    },
    {
      path: '/jupyternb',
      name: 'JupyterNb',
      component: JupyterNb
    },
    {
      path: '/graphalgo',
      name: 'NetworkGraph',
      component: NetworkGraph
    },
    {
      path: '/networkjupyternb',
      name: 'NetworkJupyterNb',
      component: NetworkJupyterNb
    },
    {
      path: '/predatorprey',
      name: 'PredatorPrey',
      component: PredatorPrey
    },
    {
      path: '/aboutme',
      name: 'AboutMe',
      component: AboutMe
    },
    {
      path: '/CV',
      name: 'CV',
      component: CV
    },
    {
      path: '/contactme',
      name: 'ContactMe',
      component: ContactMe
    }
  ],
  scrollBehavior (to, from, savedPosition) {
    return { x: 0, y: 0 }
  }

})
