<template>
 <div class="contactMeGrid">
    <top-toolbar></top-toolbar>
    
    <div class="header">
      <h1>Get In Touch</h1>
    </div>
    <div id="mainDiv">
        <div id="emailDiv" @click="sendEmail">
            <img id="emailImg" src="@/assets/mail-64.png"/>
            <h2>cahillsf9@gmail.com</h2>
            <img id="arrowImg" src="@/assets/arrow-28-32.png"/>
        </div>
        
        <h4>Or tell me a bit about yourself and send a message below:</h4>
        <form ref="msgForm">
            <p>Email:</p>
            <input class="uk-textarea" type="text"  placeholder="Enter your email" v-model="messageObj.email">
            <p>Name:</p>
            <input class="uk-textarea" type="text" placeholder="Enter your name" v-model="messageObj['submitterName']">
            <p>Message:</p>
            <input class="uk-textarea" type="text" placeholder="Enter your message" v-model="messageObj.message">
            <p :style="errorMsg" id="incorrect">Please fill in all fields and ensure a valid email address is used</p>
        </form>
        <div class="submitDiv">
            <vk-button id="submitButton" @click="recaptchaVerify">Submit</vk-button>
        </div>
        <div class="submitDiv">
          <br/>
            <h6>This site is protected by reCAPTCHA and the Google
          <a href="https://policies.google.com/privacy">Privacy Policy</a> and
          <a href="https://policies.google.com/terms">Terms of Service</a> apply.</h6>
        </div>
    </div>
        
    <vk-notification position="top-center" :messages.sync="messages"></vk-notification>
    <bottom-bar v-bind:style="bottomBarProps"></bottom-bar>
 </div>    
</template>

<script>
import axios from 'axios';
import TopToolbar from '../components/TopToolbar.vue';
import BottomBar from '../components/BottomBar.vue';
import { Button } from '../../node_modules/vuikit/lib/button';
import { Notification } from '../../node_modules/vuikit/lib/notification';
export default {
  name: 'ContactMe',
  components: {
    TopToolbar,
    BottomBar,
    VkButton: Button,
    VkNotification: Notification
  },
  data () {
    return {
      msg: 'Welcome to Your Vue.js App',
      bottomBarProps: {
        'grid-column': '1/4',
        'background-image': 'linear-gradient(to top, #c4d4e0 0%,#6e9db3 100%)',
        'display': 'grid',
        'grid-row': 5,
      },
      errorMsg: {
        display: 'none',
        color:'red'
      },
      messageObj: {
        email: '',
        submitterName: '',
        message: ''
      },
      messages: []
    }
  },
  mounted() {
      let recaptchaScript = document.createElement('script')
      recaptchaScript.setAttribute('src', 'https://www.google.com/recaptcha/api.js?render=6LdvoZIeAAAAAA6Y2rKZYlxaTMA74b6-QScWPuR6')
      document.head.appendChild(recaptchaScript)
  },
  methods: {
    sendEmail() {
      window.open("mailto:cahillsf9@gmail.com")
    },
    async recaptchaVerify(){
      console.log(JSON.stringify(this.messageObj));
      var stringMsgObj = JSON.parse(JSON.stringify(this.messageObj));
      for (var key of Object.keys(stringMsgObj)) {
          let validEmail = this.verifyEmail(stringMsgObj['email']);
          if(stringMsgObj[key] === "" || !validEmail){
            this.emptyInputField();
            return
          }
      }
      grecaptcha.ready(() => {
          grecaptcha.execute('6LdvoZIeAAAAAA6Y2rKZYlxaTMA74b6-QScWPuR6', {action: 'formSubmit'}).then((token)=> {
              console.log(String(token));
              var stringToken = JSON.parse(JSON.stringify({'token':String(token)}));
              const path = this.$hostname + '/recaptcha';
              axios.post(path, stringToken,{withCredentials:true})
              .then((res) => { 
                console.log(res.data);
                if(res.data == 'valid'){this.submitMessage();}
                else {this.captchaFailed()}
              })
              .catch((error) => {
                // eslint-disable-next-line
                console.error(error);
              });

          });
        });
    },
    async submitMessage(stringMsgObj){
        var stringMsgObj = JSON.parse(JSON.stringify(this.messageObj));
        const path = this.$hostname + '/createMessage';
        // const path = 'http://localhost:8000/createMessage';
        await axios.post(path, stringMsgObj,{withCredentials:true})
          .then((res) => { 
            // console.log(res);
            this.successfulSubmission();
          })
          .catch((error) => {
            // eslint-disable-next-line
            console.error(error);
          });
    },
    emptyInputField() {
        this.errorMsg.display = 'inline';
    },
    verifyEmail(email) {
      if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email)){return true;} 
      return false;

    },
    successfulSubmission() {
        this.messages.push({message:'Your message has been sent successfully.  Thanks for reaching out!', status:'success'})
        let keys = Object.keys(this.messageObj);
        keys.forEach(key => {
          this.messageObj[key] = '';
        })
        if (this.errorMsg.display == 'inline'){
          this.errorMsg.display = 'none';
        }
    },
    captchaFailed() {
      this.messages.push({message:'Captcha challenge failed', status:'Warning'})
        let keys = Object.keys(this.messageObj);
        keys.forEach(key => {
          this.messageObj[key] = '';
        })
        if (this.errorMsg.display == 'inline'){
          this.errorMsg.display = 'none';
        }
    }

  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

form{
    grid-column: 2;
}

form p {
    text-align: left;
    margin: 3% 0 3% 0;
    font-weight: bold;
}
h2{
    grid-column: 2;
    grid-row: 1;
    margin: 0;
    color: blue;
}

h4{
    grid-column: 2;
    text-align: left;

}
input{
    width: 100%;
}
.header {
    grid-row: 2;
}

.contactMeGrid{
  position: relative;
  display: grid;
  grid-template-columns: 1fr;
  grid-template-rows: 60px 60px 1fr 120px 60px;
}

#emailDiv {
    grid-column: 2;
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    justify-items: center;
    align-items: center;
    cursor: pointer;
}

#emailDiv:hover #arrowImg{
    padding-left: 30px;
}

#mainDiv{
    grid-row: 3;
    position: relative;
    display: grid;
    grid-template-columns: 0.2fr 0.6fr 0.2fr;
}

#emailImg {
    height: 38px;
    grid-column: 1;
    justify-self: end;
    padding-right: 8px;
    margin-top: 3px;
}

#arrowImg {
    height: 38px;
    grid-column: 3;
    justify-self: start;
    padding-left: 8px;
    margin-top: 3px;
    transition-property: padding-left;
    transition-duration: 0.3s;
    transition-timing-function: linear;
}

#submitButton {
    grid-column: 2;
    margin-top: 20px;
}

.submitDiv{
  grid-column: 2;
}
@media only screen and (max-width: 650px){
    #mainDiv{
      grid-template-columns: 0.05fr 0.9fr 0.05fr;
    }
}

</style>
