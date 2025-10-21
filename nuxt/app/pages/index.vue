<template>
  <div>
    <TopToolbar />
    <div class="singleColGrid">
      <div id="topText">
        <h1 id="home-header">{{ msg }}</h1>
        <h4 id="intro">
          Hey there! My name is Stephen Cahill and I'm a software engineer at 
          <a href="https://www.datadoghq.com/" target="_blank">Datadog</a>. Check out some of my work below:
        </h4>
      </div>
      <div id="cardsDiv">
        <div 
          v-for="card in cards" 
          :key="card._id" 
          :style="card.style" 
          :data-aos="card.animation" 
          class="card"
          @click="navigateTo(card.route)"
        >
          <h3>{{ card.title }}</h3>
          <img v-if="card.imgPath" class="card-img" :src="`/assets/project_icons/${card.imgPath}`"> 
        </div>
      </div>
      <BottomBar :style="bottomBarProps" />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUpdated } from 'vue'
import cardsData from '~/data/cards.json'

const msg = ref('Welcome')
const bottomBarProps = ref({
  'grid-column': '1 / 3',
  'background': 'linear-gradient(135deg, #52b788 0%, #1b4332 100%)',
  'display': 'none',
  'grid-row': 4
})
const cards = ref([])
const mainCards = ref([])

const generateCards = () => {
  mainCards.value = JSON.parse(JSON.stringify(cardsData))
  let keys = Object.keys(mainCards.value)

  keys.forEach(key => {  
    let i = parseInt(key) + 1
    let curProps = {
      gridColumn: 0,
      gridRow: 0,
      cursor: 'pointer'
    }
    let curCard = Object.values(mainCards.value).find(el => el._id === parseInt(key))
    curProps['gridRow'] = i
    curProps['gridColumn'] = (i % 2 == 0) ? 2 : 1
    curCard['style'] = curProps
    cards.value.push(curCard)
  })
}

const showBottomBar = () => {
  bottomBarProps.value['display'] = 'grid'
}

onMounted(() => {
  generateCards()
  showBottomBar()
})

onUpdated(() => {
  showBottomBar()
})
</script>

<style scoped>
#home-header {
  font-weight: normal;
  grid-column: 1 / 3;
}

#topText {
  grid-column: 1/3;
  grid-row: 2;
}

#cardsDiv {
  grid-row: 3;
  grid-column: 1/3;
  position: relative;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  row-gap: 5vh;
}

.card {
  background: linear-gradient(135deg, #52b788 0%, #1b4332 100%);
  color: white;
  padding: 30px 20px;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.card:hover {
  transform: translateY(-8px);
  box-shadow: 0 12px 24px rgba(45, 106, 79, 0.4);
}

.card-img {
  height: 125px;
  transition: transform 0.3s;
}

.card:hover img {
  transform: rotate(360deg);
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

h4 {
  text-align: center;
  margin: 3%;
}
</style>

