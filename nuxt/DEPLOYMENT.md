# Static Site Deployment Guide

## Generate Static Site

To generate a static version of your site:

```bash
npm run generate
```

This will create a `.output/public` directory with all static files ready for deployment.

## Preview the Static Build Locally

```bash
npm run preview
```

This serves the generated static files at `http://localhost:3000`

## Deploy Options

### Option 1: Simple HTTP Server (Local Testing)

```bash
# Install a simple HTTP server
npm install -g http-server

# Navigate to the output directory and serve
cd .output/public
http-server -p 8080
```

### Option 2: AWS S3

```bash
# Generate static files
npm run generate

# Install AWS CLI if needed
# Then sync to S3 bucket
aws s3 sync .output/public s3://your-bucket-name --delete
```



## Environment Variables for Production

Create a `.env.production` file:

```env
DD_APP_ID=your_production_app_id
DD_CLIENT_TOKEN=your_production_client_token
NODE_ENV=production
API_HOSTNAME=https://api.yoursite.com/api
```

## Build for Production with Environment Variables

```bash
# Load production env and generate
NODE_ENV=production npm run generate
```

## What Gets Generated?

The static generation will:
- ✅ Pre-render all pages
- ✅ Optimize all assets (images, CSS, JS)
- ✅ Bundle everything for production
- ✅ Create static HTML files for each route
- ✅ Include all public assets

## File Structure After Generation

```
.output/public/
├── _nuxt/           # Optimized JS/CSS bundles
├── assets/          # Your images, fonts, etc.
├── index.html       # Home page
├── aboutme.html     # About page
├── cv.html          # CV page
├── *.html           # All other pages
└── ...              # Other static assets
```

## Testing Before Deployment

1. Generate the static site: `npm run generate`
2. Preview locally: `npm run preview`
3. Test all routes and functionality
4. Check browser console for errors
5. Verify all assets load correctly

## Notes

- The generated site is 100% static HTML/CSS/JS
- No server required - can be hosted anywhere
- All routes are pre-rendered at build time
- Perfect for CDN distribution
- Fast loading and great SEO

