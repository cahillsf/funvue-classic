# Migration Guide: Vue 2 → Nuxt 4

This document outlines the key changes made when migrating from the Vue 2 application to Nuxt 4.

## Major Changes

### 1. Framework & Architecture

**Before (Vue 2):**
- Manual Vue Router configuration
- Webpack build system
- Options API
- Manual plugin registration

**After (Nuxt 4):**
- File-based routing (no router config needed)
- Vite build system (faster)
- Composition API with `<script setup>`
- Auto-imported components and composables

### 2. Project Structure

**Before:**
```
src/
├── App.vue
├── main.js
├── router/
│   └── index.js
├── components/
├── pages/
└── assets/
```

**After:**
```
app/
├── app.vue
├── components/
├── pages/          # Files here = routes
├── plugins/
└── (assets moved to public/)
```

### 3. Routing

**Before (Vue 2):**
```javascript
// router/index.js
import HomePage from '@/pages/HomePage'
export default new Router({
  routes: [
    { path: '/', name: 'HomePage', component: HomePage }
  ]
})
```

**After (Nuxt 4):**
```
pages/
├── index.vue      → /
├── aboutme.vue    → /aboutme
└── cv.vue         → /cv
```
No router configuration needed! File names = routes.

### 4. Navigation

**Before (Vue 2):**
```javascript
this.$router.push({ path: '/aboutme' })
this.$router.go(-1)
```

**After (Nuxt 4):**
```javascript
navigateTo('/aboutme')  // Auto-imported composable
$router.back()
```

### 5. Component Syntax

**Before (Options API):**
```vue
<script>
export default {
  name: 'HomePage',
  data() {
    return {
      msg: 'Welcome'
    }
  },
  methods: {
    doSomething() {
      // ...
    }
  }
}
</script>
```

**After (Composition API):**
```vue
<script setup>
import { ref } from 'vue'

const msg = ref('Welcome')

const doSomething = () => {
  // ...
}
</script>
```

### 6. Global Mixins

**Before (Vue 2):**
```javascript
// main.js
Vue.mixin({
  methods: {
    navigateToPage(route) {
      this.$router.push({ path: route })
    }
  }
})
```

**After (Nuxt 4):**
```javascript
// Use built-in composable
navigateTo(route)
```

### 7. Static Assets

**Before:**
```vue
<img src="@/assets/logo.png" />
```

**After:**
```vue
<img src="/assets/logo.png" />
```
Assets are now in `public/` and referenced with absolute paths.

### 8. Plugins

**Before (main.js):**
```javascript
import AOS from 'aos'
AOS.init()
```

**After (plugins/aos.client.ts):**
```typescript
export default defineNuxtPlugin((nuxtApp) => {
  nuxtApp.hook('app:mounted', () => {
    AOS.init()
  })
})
```

### 9. Environment Variables

**Before:**
```javascript
window.VUE_APP_DD_APP_ID
```

**After:**
```javascript
const config = useRuntimeConfig()
config.public.ddAppId
```

### 10. Component Imports

**Before:**
```javascript
import TopToolbar from '../components/TopToolbar.vue'
export default {
  components: { TopToolbar }
}
```

**After:**
```vue
<script setup>
// Components are auto-imported, no need to import!
</script>
<template>
  <TopToolbar />
</template>
```

## Removed Dependencies

### Vuikit
Vuikit was Vue 2 only and has been removed. Components were replaced with:
- Custom buttons with similar styling
- Native dropdown/navigation instead of Vuikit components
- CSS retained for visual consistency

### Vue-PDF-Embed
Replaced with native `<iframe>` for PDF display (simpler, more compatible).

## New Dependencies

- **Nuxt 4** - Framework
- **debounce v2** - Updated version for Vue 3 compatibility
- Updated versions of:
  - Three.js (^0.170.0)
  - Datadog RUM (^5.0.0)
  - Axios (^1.7.0)

## Configuration Files

### nuxt.config.ts
Replaces:
- `webpack.config.js`
- Vue Router config
- Various build configs

All configuration is now centralized in `nuxt.config.ts`.

## Running the Application

**Before:**
```bash
npm run dev  # Webpack dev server
npm run build
```

**After:**
```bash
npm run dev  # Vite dev server (faster!)
npm run build
npm run generate  # Static site generation
npm run preview  # Preview production build
```

## Benefits of Migration

1. **Faster Development**: Vite HMR is instant
2. **Better DX**: Auto-imports, TypeScript support
3. **Modern Vue 3**: Composition API, better performance
4. **SSR Ready**: Can enable server-side rendering
5. **SEO Friendly**: Better meta tag management
6. **Type Safety**: Full TypeScript support out of the box
7. **Smaller Bundle**: Better tree-shaking with Vue 3

## Breaking Changes to Note

1. All pages must be in `app/pages/` directory
2. Components are auto-imported (no manual imports)
3. Use `navigateTo()` instead of `this.$router.push()`
4. Use `$router.back()` instead of `this.$router.go(-1)`
5. Assets accessed via `/` not `@/`
6. No access to `this` in `<script setup>`
