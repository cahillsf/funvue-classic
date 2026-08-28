<template>
  <div id="footer-div">
    <footer>
      <h5>Copyright &#169; Stephen Cahill 2025</h5>
    </footer>
  </div>
</template>

<script setup>
</script>

<style scoped>
h5 {
  margin-bottom: 0;
  font-weight: bold;
}

footer {
  display: inline;
  align-self: center;
  justify-self: start;
  padding-left: 20px;
}

#footer-div {
  height: 80px;
  position: relative;
  grid-template-columns: repeat(2, 1fr);
  bottom: 0;
}

#icons {
  position: relative;
  text-align: end;
  width: auto;
  margin-left: auto;
  align-self: center;
  padding-right: 20px;
  border-spacing: 15px; /* Adds space between icons */
}

table img {
  position: relative;
  height: 35px; /* Slightly larger */
  filter: brightness(0) invert(1); /* Makes them white to pop against the green */
  opacity: 0.85;
  transition: all 0.3s ease;
}

table img:hover {
  transform: scale(1.2) translateY(-3px);
  opacity: 1;
  filter: brightness(0) invert(1) drop-shadow(0 4px 8px rgba(255,255,255,0.4));
}
</style>

