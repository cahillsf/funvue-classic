<template>
  <div class="singleColGrid">
    <TopToolbar />

    <div class="content-wrapper">
      <div id="mainDiv">
        <!-- Hero Header corresponding to the card title -->
        <div class="hero-section">
          <h1>This Website</h1>
          <p class="lead">
            Static website built with Nuxt running on AWS for about 3 bucks a month. Route 53 for DNS, ACM for TLS certs, and CloudFront distributing static assets from S3 buckets.
          </p>
        </div>

        <!-- SECTION 1: Cloud Architecture -->
        <section class="section-block">
          <div class="section-header">
            <span class="section-num">01</span>
            <h2>Cloud Architecture</h2>
          </div>
          <p class="section-intro">
            The hosting architecture leverages AWS serverless and edge services to deliver high performance, global availability, and low operational overhead. By pre-rendering the application into static assets, backend runtime vulnerabilities are eliminated and pages load near-instantaneously worldwide.
          </p>

          <div class="infra-grid">
            <div class="infra-card">
              <div class="card-badge">Origin Storage</div>
              <h3>Amazon S3</h3>
              <p>
                Static origin hosting pre-rendered HTML, Vite-bundled JavaScript chunks, CSS stylesheets, and media assets. Distinct isolated buckets are maintained for <strong>Staging / Demo</strong> and <strong>Production</strong> environments.
              </p>
              <ul class="card-bullets">
                <li>Restricted public access with Origin Access Control (OAC)</li>
                <li>Content-hashed static assets for permanent client caching</li>
                <li>Reliable, zero-server operational model</li>
              </ul>
            </div>

            <div class="infra-card">
              <div class="card-badge">Edge CDN</div>
              <h3>Amazon CloudFront</h3>
              <p>
                A global Content Delivery Network delivering content from edge locations close to users worldwide. Provides automatic TLS termination, gzip/brotli compression, and low-latency asset caching.
              </p>
              <ul class="card-bullets">
                <li>Sub-100ms global latency with worldwide edge presence</li>
                <li>Automated cache invalidation on deployment triggers</li>
                <li>Modern protocol support including HTTP/2 & HTTP/3</li>
              </ul>
            </div>

            <div class="infra-card">
              <div class="card-badge">DNS & Security</div>
              <h3>Route 53 & AWS ACM</h3>
              <p>
                Authoritative DNS resolution via Amazon Route 53 with alias records pointing directly to CloudFront distributions. SSL/TLS encryption is secured with auto-renewing certificates from AWS Certificate Manager.
              </p>
              <ul class="card-bullets">
                <li>Custom domain mapping with latency-optimized routing</li>
                <li>Automated TLS certificate renewal via DNS validation</li>
                <li>Enforced HTTPS redirect at the edge</li>
              </ul>
            </div>

            <div class="infra-card">
              <div class="card-badge">Observability</div>
              <h3>Datadog RUM Telemetry</h3>
              <p>
                Real User Monitoring (RUM) tracks client-side performance across web and mobile browsers, monitoring Core Web Vitals (LCP, FID, CLS), page views, and runtime JavaScript errors.
              </p>
              <ul class="card-bullets">
                <li>Live session analytics and front-end performance tracking</li>
                <li>Environment-specific telemetry keys injected during CI build</li>
                <li>Actionable error tracking and performance diagnostics</li>
              </ul>
            </div>
          </div>
        </section>

        <!-- SECTION 2: GitHub Actions Delivery to S3 Buckets -->
        <section class="section-block">
          <div class="section-header">
            <span class="section-num">02</span>
            <h2>GitHub Actions Delivery to S3 Buckets</h2>
          </div>
          <p class="section-intro">
            The continuous integration and continuous delivery (CI/CD) pipeline is driven entirely by GitHub Actions (<code>.github/workflows/deploy.yml</code>). Pushes automatically trigger build generation, secure cloud credential assumption, atomic S3 bucket synchronization, and CDN invalidation.
          </p>

          <!-- Delivery Pipeline Stages -->
          <div class="pipeline-flow">
            <div class="flow-box">
              <div class="step-badge">Step 1</div>
              <h4>Push Trigger</h4>
              <p>Pushes to <code>staging</code> target Demo; pushes to <code>main</code> target Production.</p>
            </div>
            <div class="flow-arrow">&rarr;</div>
            <div class="flow-box">
              <div class="step-badge">Step 2</div>
              <h4>Static Gen</h4>
              <p>Node 22 runner executes <code>npm ci</code> and <code>npm run generate</code> via Vite.</p>
            </div>
            <div class="flow-arrow">&rarr;</div>
            <div class="flow-box">
              <div class="step-badge">Step 3</div>
              <h4>OIDC Auth</h4>
              <p>Assumes AWS IAM role via GitHub OpenID Connect with zero static secrets.</p>
            </div>
            <div class="flow-arrow">&rarr;</div>
            <div class="flow-box">
              <div class="step-badge">Step 4</div>
              <h4>S3 Sync</h4>
              <p>Syncs <code>.output/public</code> with <code>--delete</code> and purges CloudFront cache.</p>
            </div>
          </div>

          <!-- Deep-dive delivery items -->
          <div class="delivery-breakdown">
            <div class="breakdown-item">
              <h3>Keyless AWS OIDC Authentication</h3>
              <p>
                Rather than storing long-lived <code>AWS_ACCESS_KEY_ID</code> and <code>AWS_SECRET_ACCESS_KEY</code> in repository secrets, the workflow uses OpenID Connect (OIDC) through <code>aws-actions/configure-aws-credentials@v4</code>. GitHub provides a cryptographically signed JWT token that AWS STS exchanges for short-lived temporary session credentials scoped strictly to the deployment role.
              </p>
            </div>
            <div class="breakdown-item">
              <h3>Multi-Environment S3 Delivery</h3>
              <p>
                The pipeline detects the target branch and dynamically routes assets to the proper AWS infrastructure:
              </p>
              <ul class="branch-list">
                <li><strong>Push to <code>staging</code>:</strong> Assumes <code>DEMO_AWS_ROLE_ARN</code>, synchronizes to <code>DEMO_S3_BUCKET</code>, and invalidates <code>DEMO_CLOUDFRONT_ID</code>.</li>
                <li><strong>Push to <code>main</code>:</strong> Assumes <code>PROD_AWS_ROLE_ARN</code>, synchronizes to <code>PROD_S3_BUCKET</code>, and invalidates <code>PROD_CLOUDFRONT_ID</code>.</li>
              </ul>
            </div>
            <div class="breakdown-item">
              <h3>Atomic Sync with Pruning & Cache Purging</h3>
              <p>
                The command <code>aws s3 sync .output/public s3://${BUCKET} --delete</code> transfers only changed or new files, while the <code>--delete</code> flag immediately removes orphaned hashed chunks from old builds. Immediately following the sync, <code>aws cloudfront create-invalidation --distribution-id ${DIST_ID} --paths "/*"</code> flushes the edge cache so visitors instantly receive the latest release.
              </p>
            </div>
          </div>

          <!-- GitHub Actions Direct Link Callout -->
          <div class="github-callout-card">
            <div class="gh-left">
              <div class="gh-header">
                <img src="/assets/ghIcon.png" class="gh-icon" alt="GitHub" />
                <div>
                  <h3>Continuous Delivery Pipeline</h3>
                  <span class="gh-sub">Automated multi-stage deployment via GitHub Actions & AWS OIDC</span>
                </div>
              </div>
              <p>
                The complete pipeline configuration, secret definitions, Node 22 build parameters, and AWS deployment steps are tracked directly in the repository source.
              </p>
              <div class="pill-tags">
                <span class="pill-tag">AWS OIDC</span>
                <span class="pill-tag">Multi-Stage</span>
                <span class="pill-tag">S3 Bucket Sync</span>
                <span class="pill-tag">CloudFront Cache Invalidation</span>
                <span class="pill-tag">Datadog Telemetry</span>
              </div>
            </div>
            <div class="gh-right">
              <a 
                href="https://github.com/cahillsf/funvue-classic/blob/staging/.github/workflows/deploy.yml" 
                target="_blank" 
                class="view-workflow-link"
              >
                View deploy.yml on GitHub &rarr;
              </a>
            </div>
          </div>
        </section>

        <!-- Actions / Links -->
        <div class="action-footer">
          <a href="https://github.com/cahillsf/funvue-classic" target="_blank" class="action-btn primary">
            View Source on GitHub
          </a>
          <button class="action-btn secondary" @click="navigateTo('/')">
            &larr; Back to Portfolio
          </button>
        </div>

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
  background: rgba(255, 255, 255, 0.88);
  border-radius: 24px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.08), 0 1px 3px rgba(0, 0, 0, 0.05);
  backdrop-filter: blur(8px);
  text-align: left;
}

.hero-section {
  margin-bottom: 40px;
  text-align: center;
}

.badge {
  display: inline-block;
  background-color: #e8f3ed;
  color: #2d6a4f;
  font-size: 0.85rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 1px;
  padding: 6px 14px;
  border-radius: 20px;
  border: 1px solid #52b788;
  margin-bottom: 16px;
}

h1 {
  font-size: 2.8rem;
  font-weight: 600;
  color: #1b4332;
  margin: 0 0 20px 0;
  text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.05);
}

.lead {
  font-size: 1.2rem;
  line-height: 1.8;
  color: #2c3e50;
  margin: 0 auto;
  max-width: 850px;
  text-align: center;
}

.section-block {
  margin: 45px 0;
  padding-top: 30px;
  border-top: 1px solid rgba(45, 106, 79, 0.15);
}

.section-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 16px;
}

.section-num {
  background: linear-gradient(135deg, #52b788 0%, #1b4332 100%);
  color: white;
  font-size: 0.9rem;
  font-weight: 800;
  padding: 4px 10px;
  border-radius: 8px;
  letter-spacing: 0.5px;
}

h2 {
  font-size: 1.85rem;
  color: #1b4332;
  margin: 0;
  font-weight: 600;
}

.section-intro {
  font-size: 1.08rem;
  line-height: 1.8;
  color: #2c3e50;
  margin: 10px 0 25px 0;
}

p {
  font-size: 1rem;
  line-height: 1.7;
  color: #2c3e50;
}

/* SECTION 1: Infra Grid */
.infra-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
  gap: 20px;
  margin-top: 25px;
}

.infra-card {
  background: #ffffff;
  border: 1px solid #d4e9df;
  border-radius: 16px;
  padding: 24px 20px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.04);
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  display: flex;
  flex-direction: column;
}

.infra-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 20px rgba(45, 106, 79, 0.12);
}

.card-badge {
  display: inline-block;
  align-self: flex-start;
  font-size: 0.75rem;
  font-weight: 700;
  text-transform: uppercase;
  color: #2d6a4f;
  background-color: #e8f3ed;
  border: 1px solid #b7dfca;
  padding: 3px 10px;
  border-radius: 12px;
  margin-bottom: 12px;
}

.infra-card h3 {
  color: #1b4332;
  font-size: 1.25rem;
  margin: 0 0 10px 0;
}

.infra-card p {
  font-size: 0.95rem;
  line-height: 1.6;
  margin: 0 0 15px 0;
  flex-grow: 1;
}

.card-bullets {
  list-style-type: none;
  padding-left: 0;
  margin: 0;
  border-top: 1px solid #f0f7f3;
  padding-top: 12px;
}

.card-bullets li {
  position: relative;
  padding-left: 18px;
  font-size: 0.88rem;
  line-height: 1.5;
  color: #4a5568;
  margin-bottom: 8px;
}

.card-bullets li::before {
  content: "•";
  position: absolute;
  left: 4px;
  color: #52b788;
  font-weight: bold;
  font-size: 1.1rem;
}

/* SECTION 2: Pipeline Flow */
.pipeline-flow {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
  margin: 25px 0;
  background: #f7faf8;
  padding: 20px 16px;
  border-radius: 16px;
  border: 1px solid #e2efe8;
}

.flow-box {
  flex: 1;
  background: #ffffff;
  border: 1px solid #d4e9df;
  border-radius: 12px;
  padding: 14px 12px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.03);
  text-align: center;
}

.step-badge {
  font-size: 0.7rem;
  font-weight: 800;
  text-transform: uppercase;
  color: #52b788;
  letter-spacing: 0.5px;
  margin-bottom: 4px;
}

.flow-box h4 {
  margin: 2px 0 6px 0;
  font-size: 1rem;
  color: #1b4332;
}

.flow-box p {
  font-size: 0.82rem;
  line-height: 1.4;
  margin: 0;
  color: #4a5568;
}

.flow-arrow {
  color: #52b788;
  font-size: 1.4rem;
  font-weight: bold;
}

/* Delivery Breakdown */
.delivery-breakdown {
  display: flex;
  flex-direction: column;
  gap: 16px;
  margin-top: 25px;
}

.breakdown-item {
  background: #ffffff;
  border: 1px solid #d4e9df;
  border-left: 5px solid #2d6a4f;
  padding: 18px 22px;
  border-radius: 0 14px 14px 0;
}

.breakdown-item h3 {
  margin: 0 0 8px 0;
  font-size: 1.15rem;
  color: #1b4332;
}

.breakdown-item p {
  margin: 0;
  font-size: 0.98rem;
  line-height: 1.65;
  color: #2c3e50;
}

.branch-list {
  list-style-type: none;
  padding-left: 0;
  margin: 10px 0 0 0;
}

.branch-list li {
  position: relative;
  padding-left: 20px;
  font-size: 0.94rem;
  line-height: 1.6;
  color: #2c3e50;
  margin-bottom: 6px;
}

.branch-list li::before {
  content: "→";
  position: absolute;
  left: 0;
  color: #2d6a4f;
  font-weight: bold;
}

/* GitHub Callout Card */
.github-callout-card {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 25px;
  background: #ffffff;
  border: 2px solid #d4e9df;
  border-radius: 16px;
  padding: 24px 28px;
  margin-top: 30px;
  box-shadow: 0 4px 14px rgba(0, 0, 0, 0.05);
  transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.github-callout-card:hover {
  border-color: #52b788;
  box-shadow: 0 8px 24px rgba(45, 106, 79, 0.12);
}

.gh-left {
  flex: 1;
}

.gh-header {
  display: flex;
  align-items: center;
  gap: 14px;
  margin-bottom: 10px;
}

.gh-icon {
  width: 36px;
  height: 36px;
}

.gh-header h3 {
  margin: 0;
  font-size: 1.25rem;
  color: #1b4332;
}

.gh-sub {
  font-size: 0.85rem;
  color: #2d6a4f;
  font-weight: 600;
}

.gh-left p {
  font-size: 0.95rem;
  line-height: 1.6;
  margin: 0 0 14px 0;
  color: #4a5568;
}

.pill-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
}

.pill-tag {
  background: #e8f3ed;
  color: #1b4332;
  font-size: 0.78rem;
  font-weight: 600;
  padding: 4px 12px;
  border-radius: 20px;
  border: 1px solid #c2e2d2;
}

.gh-right {
  flex-shrink: 0;
}

.view-workflow-link {
  display: inline-block;
  background: linear-gradient(135deg, #52b788 0%, #1b4332 100%);
  color: white;
  padding: 12px 20px;
  border-radius: 24px;
  font-size: 0.95rem;
  font-weight: 600;
  text-decoration: none;
  box-shadow: 0 4px 12px rgba(45, 106, 79, 0.25);
  transition: all 0.2s ease;
  white-space: nowrap;
}

.view-workflow-link:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 18px rgba(45, 106, 79, 0.35);
  color: white;
  text-decoration: none;
}

code {
  background-color: #e8f3ed;
  color: #1b4332;
  padding: 2px 6px;
  border-radius: 4px;
  font-size: 0.9em;
  font-family: Monaco, Consolas, "Courier New", monospace;
}

/* Action Footer */
.action-footer {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-top: 50px;
  padding-top: 30px;
  border-top: 1px solid rgba(45, 106, 79, 0.15);
}

.action-btn {
  padding: 12px 24px;
  border-radius: 24px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  text-decoration: none;
  border: none;
}

.action-btn.primary {
  background: linear-gradient(135deg, #52b788 0%, #1b4332 100%);
  color: white;
  box-shadow: 0 4px 12px rgba(45, 106, 79, 0.3);
}

.action-btn.primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(45, 106, 79, 0.4);
  text-decoration: none;
  color: white;
}

.action-btn.secondary {
  background: rgba(45, 106, 79, 0.1);
  color: #1b4332;
}

.action-btn.secondary:hover {
  background: rgba(45, 106, 79, 0.2);
  transform: translateY(-2px);
}

@media (max-width: 768px) {
  h1 {
    font-size: 2.2rem;
  }
  
  #mainDiv {
    padding: 30px 20px;
  }
  
  .pipeline-flow {
    flex-direction: column;
  }

  .flow-arrow {
    transform: rotate(90deg);
  }
  
  .github-callout-card {
    flex-direction: column;
    align-items: stretch;
    text-align: left;
    padding: 20px;
  }

  .gh-right {
    margin-top: 10px;
  }

  .view-workflow-link {
    display: block;
    text-align: center;
    width: auto;
  }

  .action-footer {
    flex-direction: column;
  }

  .action-btn {
    text-align: center;
    width: 100%;
  }
}
</style>

