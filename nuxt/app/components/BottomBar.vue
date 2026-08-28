<template>
  <div id="footer-div">
    <footer>
      <h5>Copyright &#169; Stephen Cahill 2026</h5>
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
</style>

