<template>
<div>
  <top-toolbar></top-toolbar>
  <div class="singleColGrid">
    <!-- <top-toolbar></top-toolbar> -->
    <div id="topText">
      <h1 id="home-header">{{ msg }}</h1>
      <h4 id="intro">Hey there!  My name is Stephen Cahill and I'm a technologist working as a Solutions Engineer at <a href="https://www.datadoghq.com/" target="_blank">Datadog</a>.  Check out some of my work below:</h4>
    </div>
    <div id="cardsDiv">
      <!-- loop through cards in js -->
      <vk-card v-for="card in cards" v-bind:key="card.id" v-bind:style="card.style" :data-aos="card.animation" type="primary" @click="navigateToPage(card.route)" hover>
        <vk-card-title>
          {{ card.title }}
        </vk-card-title>
        <img class="card-img" v-if="card.imgPath" :src="require(`@/assets/project_icons/${card.imgPath}`)"> 
      </vk-card>
    </div>
    <bottom-bar v-bind:style="bottomBarProps"></bottom-bar>
  </div>
</div>
</template>

<script>
import axios from 'axios';
import TopToolbar from '../components/TopToolbar.vue';
import BottomBar from '../components/BottomBar.vue';
import { Card, CardTitle } from '../../node_modules/vuikit/lib/card';
import cardsData from '@/assets/cards.json'
export default {
  name: 'HomePage',
  components: {
    TopToolbar,
    VkCard: Card,
    VkCardTitle: CardTitle,
    BottomBar
  },
  data () {
    return {
      //TODO: would be nince to have the margin of the bottom tool bar dynamically generated based on the number of cards
      msg: 'Welcome',
      bottomBarProps: {
        'grid-column': '1 / 3',
        'background-image': 'linear-gradient(to top, #c4d4e0 0%,#6e9db3 100%)',
        'display': 'none',
        'grid-row': 4,
        // 'margin-top': '30vh', 
      },
      cards: [],
      mainCards: []
      }
    },
    created(){
      // this.getCards();
      this.generateCards();
      this.showBottomBar();
    },
    updated(){
      this.showBottomBar();
    },
    methods: {
      generateCards() {
        //mainCards are the cards received from calling function getCards()
        this.mainCards = JSON.parse(JSON.stringify(cardsData));
        let keys = Object.keys(this.mainCards);

        //loop through the provided cards adding the proper css to display
        //cards on alternate sides of the webpage with corresponding animation
        keys.forEach(key => {  
          let i = parseInt(key) + 1;
          //define the the style properties object
          let curProps = {
            gridColumn: 0,
            gridRow: 0,
            cursor: 'pointer'
          }
          let curCard = Object.values(this.mainCards).find(el => el._id === parseInt(key));
          // console.log(curCard);
          //grid row will correspond the index of the loop
          //as cards are displayed straight down the page
          curProps['gridRow'] = i;
          //column alternates page sides
          //even numbers on the right odd numbers on the left
          curProps['gridColumn'] = (i % 2 == 0)? 2 : 1;
          //assign grid props to card object
          curCard['style'] = curProps;
          //add complete card to cards array
          this.cards.push(curCard);
          // console.log(curCard);
        })
      },
      showBottomBar() {
        this.bottomBarProps['display'] = 'grid';
      },
      navigateToPage(route) {
        this.$router.push({ path: route });
      }
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>



#home-header {
  font-weight: normal;
  /* grid-row: 2; */
  grid-column: 1 / 3;
}


#topText {
  grid-column: 1/3;
  grid-row: 2;
}

#cardsDiv{
  grid-row: 3;
  grid-column: 1/3;
  position: relative;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  row-gap: 5vh;
}

.card-img {
  height: 125px;
  transition: transform 0.3s;
}

.uk-card:hover img{
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
