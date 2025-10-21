// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true },
  
  app: {
    head: {
      title: 'Stephen Cahill - Developer Portfolio',
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'description', content: 'Stephen Cahill - Solutions Engineer and Developer Portfolio' }
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
        { rel: 'stylesheet', href: '/vuikit.css' }
      ]
    }
  },

  css: [
    'aos/dist/aos.css'
  ],

  runtimeConfig: {
    public: {
      ddAppId: process.env.DD_APP_ID || '',
      ddClientToken: process.env.DD_CLIENT_TOKEN || '',
      env: process.env.NODE_ENV || 'dev',
      apiHostname: process.env.API_HOSTNAME || 'http://localhost:8000/api'
    }
  },

  vite: {
    optimizeDeps: {
      include: ['three', 'aos']
    }
  }
})
