<template>
  <div id="app">
    <NuxtPage />
  </div>
</template>

<style>
@import 'aos/dist/aos.css';

@font-face {
  font-family: "Playfair";
  src: url(/assets/fonts/PlayfairDisplay-Regular.ttf) format("truetype");
  font-weight: normal;
  font-style: normal;
}

#app {
  font-family: "Playfair", Times, serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #1a1a1a;
  margin-top: 0px;
  position: relative;
  background-color: #e8f3ed;
  background-image: 
    linear-gradient(30deg, #d4e9df 12%, transparent 12.5%, transparent 87%, #d4e9df 87.5%, #d4e9df),
    linear-gradient(150deg, #d4e9df 12%, transparent 12.5%, transparent 87%, #d4e9df 87.5%, #d4e9df),
    linear-gradient(30deg, #d4e9df 12%, transparent 12.5%, transparent 87%, #d4e9df 87.5%, #d4e9df),
    linear-gradient(150deg, #d4e9df 12%, transparent 12.5%, transparent 87%, #d4e9df 87.5%, #d4e9df);
  background-size: 80px 140px;
  background-position: 0 0, 0 0, 40px 70px, 40px 70px;
  min-height: 100vh;
}

.homeGrid {
  position: relative;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  row-gap: 5%;
}

.singleColGrid {
  position: relative;
  display: grid;
  grid-template-columns: 1fr;
  row-gap: 60px;
}

canvas {
  width: 90vw;
  margin-bottom: 8px;
  box-shadow: 0 2px 8px 4px rgba(0, 0, 0, 0.1);
}

p {
  text-align: left;
  margin: 3%;
}

div.grecaptcha-badge { 
  visibility: hidden; 
}

a {
  color: #2d6a4f;
  text-decoration: none;
  transition: color 0.3s ease;
}

a:hover {
  color: #52b788;
  text-decoration: underline;
}

a:visited {
  color: #1b4332;
}
</style>
