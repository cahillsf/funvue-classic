<template>
  <div class="singleColGrid">
    <TopToolbar />

    <div class="content-wrapper">
      <div id="mainDiv">
        <!-- Hero Header with top level title -->
        <div class="hero-section">
          <h1>Portfolio Site Infrastructure</h1>
          <p class="lead">
            Static website built with Nuxt running on AWS for about 3 bucks a month.
            Route 53 for DNS, ACM for TLS certs, and CloudFront distributing static assets from private S3 origins via Origin Access Control (OAC).
          </p>
          <div class="hero-actions">
            <a 
              href="https://github.com/cahillsf/funvue-classic" 
              target="_blank" 
              class="github-source-btn"
            >
              <img src="/assets/ghIcon.png" class="gh-btn-icon" width="20" height="20" alt="GitHub" />
              <span>View Source on GitHub &rarr;</span>
            </a>
          </div>
        </div>

        <!-- SECTION 1: Cloud Architecture & Topology -->
        <section class="section-block">
          <div class="section-header">
            <span class="section-num">01</span>
            <div>
              <h2>Cloud Architecture &amp; Topology</h2>
            </div>
          </div>

          <!-- Focal Point: SVG Architecture Diagram -->
          <div class="diagram-card">
            <img 
              src="/assets/architecture-diagram.svg" 
              alt="Portfolio Site Infrastructure Diagram" 
              class="vector-diagram-img"
              width="1190"
              height="530"
              loading="eager"
            />
          </div>
        </section>

        <!-- SECTION 2: GitHub Actions Delivery to S3 Buckets -->
        <section class="section-block">
          <div class="section-header">
            <span class="section-num">02</span>
            <div>
              <h2>GitHub Actions Delivery to S3 Buckets</h2>
            </div>
          </div>

          <!-- Focal Point: CI/CD Pipeline SVG Diagram -->
          <div class="diagram-card">
            <img 
              src="/assets/cicd-pipeline-diagram.svg" 
              alt="GitHub Actions CI/CD Delivery Pipeline Diagram" 
              class="vector-diagram-img"
              width="1190"
              height="470"
              loading="eager"
            />
          </div>

          <!-- Direct Link to GitHub Workflow -->
          <div class="workflow-action-row">
            <a 
              href="https://github.com/cahillsf/funvue-classic/blob/main/.github/workflows/deploy.yml" 
              target="_blank" 
              class="workflow-btn"
            >
              <img src="/assets/ghIcon.png" class="gh-btn-icon" width="20" height="20" alt="GitHub" />
              <span>View deploy.yml on GitHub &rarr;</span>
            </a>
          </div>
        </section>

        <!-- Actions / Links -->
        <div class="action-footer">
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
  padding-bottom: 50px;
  grid-row: 2;
}

#mainDiv {
  padding: 40px 5%;
  max-width: 1100px;
  margin: 0 auto;
  background: rgba(255, 255, 255, 0.9);
  border-radius: 24px;
  box-shadow: 0 20px 40px rgba(0, 0, 0, 0.08), 0 1px 3px rgba(0, 0, 0, 0.05);
  backdrop-filter: blur(8px);
  text-align: left;
}

.hero-section {
  margin-bottom: 35px;
  text-align: center;
}

.badge {
  display: inline-block;
  background-color: #e8f3ed;
  color: #2d6a4f;
  font-size: 0.8rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 1.2px;
  padding: 6px 16px;
  border-radius: 20px;
  border: 1px solid #52b788;
  margin-bottom: 16px;
}

h1 {
  font-size: 2.8rem;
  font-weight: 700;
  color: #1b4332;
  margin: 0 0 16px 0;
  text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.05);
}

.lead {
  font-size: 1.15rem;
  line-height: 1.8;
  color: #2c3e50;
  margin: 0 auto;
  max-width: 860px;
  text-align: center;
}

.hero-actions {
  display: flex;
  justify-content: center;
  margin-top: 22px;
}

.github-source-btn {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  background: #ffffff;
  color: #1b4332;
  border: 1.5px solid #d4e9df;
  padding: 10px 22px;
  border-radius: 24px;
  font-size: 0.95rem;
  font-weight: 600;
  text-decoration: none;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  transition: all 0.2s ease;
}

.github-source-btn:hover {
  background: #f0f7f3;
  border-color: #52b788;
  transform: translateY(-2px);
  box-shadow: 0 5px 14px rgba(45, 106, 79, 0.16);
  text-decoration: none;
  color: #1b4332;
}

.section-block {
  margin: 45px 0;
  padding-top: 30px;
  border-top: 1px solid rgba(45, 106, 79, 0.15);
}

.section-header {
  display: flex;
  align-items: flex-start;
  gap: 16px;
  margin-bottom: 20px;
}

.section-num {
  background: linear-gradient(135deg, #52b788 0%, #1b4332 100%);
  color: white;
  font-size: 0.95rem;
  font-weight: 800;
  padding: 5px 12px;
  border-radius: 8px;
  letter-spacing: 0.5px;
  margin-top: 4px;
}

h2 {
  font-size: 1.85rem;
  color: #1b4332;
  margin: 0;
  font-weight: 700;
}

.section-tagline {
  margin: 4px 0 0 0;
  font-size: 0.95rem;
  color: #2d6a4f;
  font-weight: 500;
}

.section-intro {
  font-size: 1.05rem;
  line-height: 1.75;
  color: #2c3e50;
  margin: 10px 0 25px 0;
}

p {
  font-size: 1rem;
  line-height: 1.7;
  color: #2c3e50;
}

/* =========================================================
   DIAGRAM CARD (FOCAL POINT OF PART 1)
   ========================================================= */
.diagram-card {
  background: #090d16;
  border: 1px solid rgba(255, 255, 255, 0.12);
  border-radius: 18px;
  box-shadow: 0 20px 45px -10px rgba(0, 0, 0, 0.6);
  margin: 25px 0 10px 0;
  overflow: hidden;
  padding: 10px;
}

.vector-diagram-img {
  display: block;
  width: 100%;
  max-width: 1190px;
  height: auto;
  border-radius: 12px;
}

/* Workflow Action Button Row */
.workflow-action-row {
  display: flex;
  justify-content: flex-end;
  margin-top: 15px;
}

.workflow-btn {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  background: #ffffff;
  color: #1b4332;
  border: 1.5px solid #d4e9df;
  padding: 10px 18px;
  border-radius: 20px;
  font-size: 0.92rem;
  font-weight: 600;
  text-decoration: none;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
  transition: all 0.2s ease;
}

.workflow-btn:hover {
  background: #f0f7f3;
  border-color: #52b788;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(45, 106, 79, 0.15);
  text-decoration: none;
  color: #1b4332;
}

.gh-btn-icon {
  width: 20px;
  height: 20px;
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
    padding: 30px 16px;
  }

  .workflow-action-row {
    justify-content: center;
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
