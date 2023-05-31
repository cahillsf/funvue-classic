<template>
    <div id="footer-div">
        <footer>
            <h5>Copyright &#169; Stephen Cahill 2023</h5>
        </footer>
        <table id="icons">
            <td><a href="https://github.com/cahillsf" target="_blank"><img src="@/assets/ghIcon.png"/></a></td>
            <td><a href="https://www.linkedin.com/in/cahillsf/" target="_blank"><img src="@/assets/lin.png"/></a></td>
            <td><a href="mailto:cahillsf9@gmail.com" target="_blank"><img src="@/assets/email.png"/></a></td>
        </table>

    </div>
</template>

<script>
import { Button, ButtonLink } from '../../node_modules/vuikit/lib/button';
export default {
  name: 'BottomBar',
  components: {
    VkButton: Button,
    VkButtonLink: ButtonLink
  },
  data () {
    return {
        
    }
  },
  methods: {
   
  },
};
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
    /* grid-row: 8; */
}

#icons{
    position: relative;
    text-align: end;
    width: auto;
    margin-left: auto;
    align-self: center;
    padding-right: 10px;
    
}
table img{
    position: relative;
	height: 30px;
   
}
</style>
