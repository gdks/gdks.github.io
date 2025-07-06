# Gavin Stewart - Personal Portfolio 🚀

[![Website](https://img.shields.io/website?url=https%3A%2F%2Fwww.gdks.co.uk&style=for-the-badge&logo=firefox&logoColor=white)](https://www.gdks.co.uk)
[![GitHub Pages](https://img.shields.io/badge/github%20pages-121013?style=for-the-badge&logo=github&logoColor=white)](https://gdks.github.io)

[![Continuous Deployment](https://github.com/gdks/gdks.github.io/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/gdks/gdks.github.io/actions/workflows/ci-cd.yml)
[![Security Scan](https://github.com/gdks/gdks.github.io/actions/workflows/security-scan.yml/badge.svg)](https://github.com/gdks/gdks.github.io/actions/workflows/security-scan.yml)
[![CI](https://github.com/gdks/gdks.github.io/actions/workflows/ci.yml/badge.svg)](https://github.com/gdks/gdks.github.io/actions/workflows/ci.yml)

[![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white)](https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/HTML5)
[![CSS3](https://img.shields.io/badge/css3-%231572B6.svg?style=for-the-badge&logo=css3&logoColor=white)](https://developer.mozilla.org/en-US/docs/Web/CSS)
[![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E)](https://developer.mozilla.org/en-US/docs/Web/JavaScript)

[![Accessibility](https://img.shields.io/badge/accessibility-A11Y-brightgreen?style=for-the-badge&logo=web-accessibility&logoColor=white)](https://www.w3.org/WAI/)
[![Performance](https://img.shields.io/badge/lighthouse-performance-brightgreen?style=for-the-badge&logo=lighthouse&logoColor=white)](https://developers.google.com/web/tools/lighthouse)
[![SEO](https://img.shields.io/badge/seo-optimized-brightgreen?style=for-the-badge&logo=google&logoColor=white)](https://developers.google.com/search/docs)

> **A modern, responsive portfolio website showcasing 18+ years of software engineering excellence**

## 🌟 About

Personal portfolio of **Gavin Stewart**, a Software Engineer and Engineering Leader based in Edinburgh, Scotland. Features modern design, comprehensive accessibility, and automated quality assurance.

**🌐 Live Site:** [www.gdks.co.uk](https://www.gdks.co.uk)

## 🚀 Quick Start

```bash
# Clone and setup
git clone https://github.com/gdks/gdks.github.io.git
cd gdks.github.io
npm install

# Start development server
make serve
# or
python3 -m http.server 8000

# Open http://localhost:8000
```

## 🛠️ Development

### Prerequisites

- Node.js 18+
- Modern web browser

### Local CI Framework

This project includes a comprehensive local CI framework using Make:

```bash
# Quick checks (linting, formatting, HTML validation)
make ci-quick

# Full CI suite (accessibility, performance, browser tests)
make ci-full

# Individual checks
make lint          # All linting
make security      # Security scanning
make accessibility # Accessibility testing
make lighthouse    # Performance testing
```

### Key Make Targets

- `make install` - Install all dependencies
- `make serve` - Start development server
- `make ci` - Run quick CI checks
- `make ci-full` - Run complete test suite
- `make clean` - Clean up and stop server

## 🛡️ Quality Standards

| Category           | Tool             | Threshold     |
| ------------------ | ---------------- | ------------- |
| **Performance**    | Lighthouse       | ≥80%          |
| **Accessibility**  | axe-core + Pa11y | ≥90%          |
| **Best Practices** | Lighthouse       | ≥80%          |
| **SEO**            | Lighthouse       | ≥80%          |
| **Security**       | Trivy            | Zero critical |
| **Code Quality**   | Linters          | Zero errors   |

## 🔄 CI/CD

- **Automated testing** on every PR and push
- **Security scanning** with Trivy and TruffleHog
- **Performance monitoring** with Lighthouse
- **Cross-browser testing** with Playwright
- **Automatic deployment** to GitHub Pages

## 📞 Connect

- **🌐 Website**: [www.gdks.co.uk](https://www.gdks.co.uk)
- **💼 LinkedIn**: [linkedin.com/in/gavinstewart](https://www.linkedin.com/in/gavinstewart)
- **👨‍💻 GitHub**: [github.com/gdks](https://github.com/gdks)

<div align="center">
  <strong>⚡ Crafted with passion in Edinburgh, Scotland 🏴󠁧󠁢󠁳󠁣��󠁿</strong>
</div>
