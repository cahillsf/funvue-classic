<template>
  <div class="singleColGrid">
    <TopToolbar />
    <div class="content-wrapper">
      <div id="mainDiv"> 
      <img id="portrait" alt="photo of me" src="/assets/aboutme_assets/portrait-redux.jpg" />
      <p>
        Thanks for visiting my website! I hope you're enjoying your stay; if you're interested in the source code you can take a look <span><a href="https://github.com/cahillsf/funvue-classic" target="_blank">here</a></span>. I enjoy learning new technologies and improving my programming skills, with a particular focus on infrastructure engineering and systems architecture. As a software engineer at Datadog, I work on CI/CD tooling, automation pipelines, and cloud infrastructure across AWS, Azure, and GCP. Most of my day-to-day involves Go, Terraform, and Kubernetes. On the side, I'm having fun with <span><a href="https://github.com/cahillsf/rpi-particulate-sensor" target="_blank">Linux embedded systems and hardware engineering</a></span> through a Raspberry Pi particulate sensor project.
      </p>
      <p>
        My road to working in IT several years ago when I began pursuing an intellectual curiosity: computer science and programming. Starting with a few MOOC's and intro Python courses, my desire to learn took hold of me and I enrolled in the <span><a href="https://engineering.nyu.edu/academics/programs/nyu-tandon-bridge" target="_blank">NYU Tandon online bridge program</a></span> which teaches the fundamentals of computer science. The program is designed for people with limited STEM backgrounds to gather the skills needed to pursue a Master's degree in computer science. This intensive six-month curriculum covered programming, discrete mathematics and networking. Following the NYU bridge program, I began pursuit of a <span><a href="https://seidenberg.pace.edu/computer-science-ms" target="_blank">Master's degree in computer science at Pace University</a></span> which I completed in May 2021. 
      </p>
      <p>
        Prior to working in tech, I spent eight years working as a restaurant manager in the dynamic and thriving dining scence of New York City. Over the course of that time I've managed a diverse range of businesses from quickly growing fast-casual chains such as Dos Toros and Luke's Lobster, to destination pizzerias like Roberta's in Bushwick. Along the way I accumulated the skills to handle full HR admininstrative responsibilities for staff sizes ranging from five to fifty employees, develop insightful profit and loss business analyses, juggle vendor relationships, and take ownership over all the nuances embedded in operating successful, high grossing, fast-paced businesses.
      </p>
      </div>
    </div>
    <BottomBar :style="bottomBarProps" />
  </div>
</template>

<script setup>
import { ref } from 'vue'

const bottomBarProps = ref({
  'grid-column': '1',
  'background': 'linear-gradient(135deg, #52b788 0%, #1b4332 100%)',
  'display': 'grid',
  'grid-row': 3
})
</script>

<style scoped>
.content-wrapper {
  padding-top: 100px;
  padding-bottom: 40px;
  grid-row: 2;
}

#mainDiv {
  padding: 40px 5%;
  max-width: 1000px;
  margin: 0 auto;
  background: rgba(255, 255, 255, 0.7);
  border-radius: 12px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
}

#mainDiv h1 {
  font-size: 3rem;
  font-weight: 600;
  color: #1b4332;
  margin-bottom: 30px;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.05);
}

#mainDiv p {
  margin: 25px 0;
  font-size: 1.15rem;
  line-height: 1.8;
  color: #2c3e50;
  text-align: justify;
  font-weight: 400;
}

#mainDiv p:first-of-type {
  font-size: 1.2rem;
  color: #1a1a1a;
}

#portrait {
  position: relative;
  width: 220px;
  height: auto;
  top: 0;
  float: left;
  border-radius: 16px;
  margin-left: 0;
  margin-right: 25px;
  margin-bottom: 15px;
  box-shadow: 0 8px 16px rgba(27, 67, 50, 0.3);
  border: 4px solid white;
  transition: transform 0.3s ease;
}

#portrait:hover {
  transform: scale(1.05);
}
</style>

