import { datadogRum } from '@datadog/browser-rum'

export default defineNuxtPlugin(() => {
  const config = useRuntimeConfig()
  
  datadogRum.init({
    applicationId: config.public.ddAppId || 'YOUR_APP_ID',
    clientToken: config.public.ddClientToken || 'YOUR_CLIENT_TOKEN',
    site: 'datadoghq.com',
    service: 'nuxt-portfolio',
    env: config.public.env || 'dev',
    version: '1.0.0',
    sessionSampleRate: 100,
    sessionReplaySampleRate: 100,
    trackUserInteractions: true,
    trackResources: true,
    trackLongTasks: true,
    defaultPrivacyLevel: 'mask-user-input',
    allowedTracingUrls: [
      'http://localhost:8000',
      /https:\/\/.*\.stephencahill\.net/
    ]
  })
  
  datadogRum.startSessionReplayRecording()
})

