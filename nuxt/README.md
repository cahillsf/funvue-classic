# Stephen Cahill - Portfolio (Nuxt 4)

This is a Nuxt 4 port of the original Vue 2 portfolio website 

## Features

- Modern Nuxt 4 with Vue 3 Composition API
- File-based routing
- Three.js 3D visualizations
- AOS (Animate On Scroll) animations
- Datadog RUM integration
- Responsive design with mobile support
- Multiple project showcases including:
  - Decision Tree Algorithmic Analysis
  - Graph Algorithms with NetworkX
  - Bridget Riley Canvas Project
  - C++ Predator-Prey Simulation
  - Three.js 3D Tooth Model

## Setup

Install dependencies:

```bash
npm install
```

## Development

Start the development server on `http://localhost:3000`:

```bash
npm run dev
```

## Production

Build the application for production:

```bash
npm run build
```

Preview the production build locally:

```bash
npm run preview
```

## Environment Variables

Create a `.env` file in the root directory with the following variables:

```
DD_APP_ID=your_datadog_app_id
DD_CLIENT_TOKEN=your_datadog_client_token
NODE_ENV=production
# API_HOSTNAME=https://your-api-hostname.com/api -->
```

## Project Structure

```
nuxt/
├── app/
│   ├── app.vue              # Root component with global styles
│   ├── components/          # Reusable components
│   │   ├── TopToolbar.vue
│   │   └── BottomBar.vue
│   ├── pages/               # File-based routing pages
│   │   ├── index.vue        # Home page
│   │   ├── aboutme.vue
│   │   ├── cv.vue
│   │   ├── dectree.vue
│   │   ├── graphalgo.vue
│   │   ├── jupyternb.vue
│   │   ├── networkjupyternb.vue
│   │   ├── predatorprey.vue
│   │   ├── rileycanvas.vue
│   │   ├── rileyproject.vue
│   │   ├── threescene.vue
│   │   └── toothpage.vue
│   └── plugins/             # Nuxt plugins
│       ├── aos.client.ts    # AOS initialization
│       └── datadog.client.ts # Datadog RUM setup
├── public/                  # Static assets
│   ├── assets/              # Images, fonts, JSON
│   ├── *.html               # Jupyter notebooks as HTML
│   ├── *.pdf                # CV PDF
│   └── *.obj                # 3D models
├── nuxt.config.ts           # Nuxt configuration
└── package.json             # Dependencies
```

## Migration Notes

This project was migrated from Vue 2 to Nuxt 4 with the following changes:

- **Options API → Composition API**: All components now use `<script setup>`
- **Vue Router**: Replaced with Nuxt's file-based routing
- **Vuikit**: Removed (Vue 2 only), replaced with custom components/styles
- **Global mixins**: Replaced with Nuxt's `navigateTo()` composable
- **Static files**: Moved to `public/` directory
- **Environment variables**: Now managed through Nuxt's runtime config
- **Plugins**: AOS and Datadog now initialized as Nuxt plugins

## Technologies Used

- **Nuxt 4** - The Intuitive Vue Framework
- **Vue 3** - Progressive JavaScript Framework
- **Three.js** - 3D Graphics Library
- **AOS** - Animate On Scroll Library
- **Datadog RUM** - Real User Monitoring
- **Axios** - HTTP Client
- **TypeScript** - Type Safety
