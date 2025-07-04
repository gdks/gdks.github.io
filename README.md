# Gavin Stewart - Personal Portfolio 🚀

[![Website](https://img.shields.io/website?url=https%3A%2F%2Fwww.gdks.co.uk&style=for-the-badge&logo=firefox&logoColor=white)](https://www.gdks.co.uk)
[![GitHub Pages](https://img.shields.io/badge/github%20pages-121013?style=for-the-badge&logo=github&logoColor=white)](https://gdks.github.io)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

[![Continuous Deployment](https://github.com/gdks/gdks.github.io/actions/workflows/ci-cd.yml/badge.svg)](https://github.com/gdks/gdks.github.io/actions/workflows/ci-cd.yml)
[![Security Scan](https://github.com/gdks/gdks.github.io/actions/workflows/security-scan.yml/badge.svg)](https://github.com/gdks/gdks.github.io/actions/workflows/security-scan.yml)
[![CI](https://github.com/gdks/gdks.github.io/actions/workflows/ci.yml/badge.svg)](https://github.com/gdks/gdks.github.io/actions/workflows/ci.yml)
[![PR Checks](https://github.com/gdks/gdks.github.io/actions/workflows/pr-checks.yml/badge.svg)](https://github.com/gdks/gdks.github.io/actions/workflows/pr-checks.yml)

[![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white)](https://developer.mozilla.org/en-US/docs/Web/Guide/HTML/HTML5)
[![CSS3](https://img.shields.io/badge/css3-%231572B6.svg?style=for-the-badge&logo=css3&logoColor=white)](https://developer.mozilla.org/en-US/docs/Web/CSS)
[![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E)](https://developer.mozilla.org/en-US/docs/Web/JavaScript)

[![Accessibility](https://img.shields.io/badge/accessibility-A11Y-brightgreen?style=for-the-badge&logo=web-accessibility&logoColor=white)](https://www.w3.org/WAI/)
[![Performance](https://img.shields.io/badge/lighthouse-performance-brightgreen?style=for-the-badge&logo=lighthouse&logoColor=white)](https://developers.google.com/web/tools/lighthouse)
[![SEO](https://img.shields.io/badge/seo-optimized-brightgreen?style=for-the-badge&logo=google&logoColor=white)](https://developers.google.com/search/docs)

> **A modern, responsive portfolio website showcasing 18+ years of software engineering excellence**

## 🌟 About

This is the personal portfolio website of **Gavin Stewart**, a Software Engineer and Engineering Leader based in Edinburgh, Scotland. The site showcases professional experience, technical skills, and innovative projects in the field of software engineering.

### 🎯 Key Features

- **🎨 Modern Design**: Clean, professional interface with smooth animations
- **📱 Fully Responsive**: Optimized for all devices and screen sizes
- **⚡ Performance Optimized**: Fast loading times and optimal user experience
- **🔍 SEO Friendly**: Structured data and meta tags for better search visibility
- **♿ Accessible**: WCAG compliant with comprehensive accessibility features
- **🔒 Secure**: Regular security scanning and best practices implementation

## 🚀 Live Demo

**🌐 Visit:** [www.gdks.co.uk](https://www.gdks.co.uk)

## 🛠️ Tech Stack

| Category | Technologies |
|----------|-------------|
| **Frontend** | HTML5, CSS3, JavaScript (ES6+) |
| **Styling** | Custom CSS, Font Awesome Icons, Google Fonts |
| **Build Tools** | NPM, Prettier, HTMLHint, Stylelint, ESLint |
| **Testing** | Playwright, Lighthouse, axe-core, Pa11y |
| **Deployment** | GitHub Pages, GitHub Actions |
| **Security** | Trivy, TruffleHog, Dependabot |

## 📊 Quality Assurance

This project maintains high quality standards through comprehensive automated testing:

### 🔍 Code Quality
- **HTML Validation**: W3C HTML5 validator
- **CSS Linting**: Stylelint with standard configuration
- **JavaScript Linting**: ESLint with recommended rules
- **Code Formatting**: Prettier for consistent code style

### 🛡️ Security
- **Vulnerability Scanning**: Trivy security scanner
- **Secret Detection**: TruffleHog for hardcoded secrets
- **Dependency Scanning**: Automated security updates

### 🎯 Performance & Accessibility
- **Lighthouse Audits**: Performance, Accessibility, Best Practices, SEO
- **Cross-browser Testing**: Chrome, Firefox, Safari compatibility
- **Accessibility Testing**: axe-core and Pa11y validation
- **Responsive Design**: Multiple viewport testing

## 🚀 Getting Started

### Prerequisites
- Node.js 18+ (for development tools)
- Modern web browser
- Git

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/gdks/gdks.github.io.git
   cd gdks.github.io
   ```

2. **Install development dependencies**
   ```bash
   npm install
   ```

3. **Start local server**
   ```bash
   # Using Python (recommended)
   python3 -m http.server 8000
   
   # Or using Node.js
   npx http-server -p 8000
   ```

4. **Open in browser**
   ```
   http://localhost:8000
   ```

### 🧪 Running Tests

```bash
# Install test dependencies
npm install

# Run all quality checks
npm run lint:html
npm run lint:css
npm run lint:js
npm run format:check

# Run accessibility tests
npm run test:a11y

# Run performance tests
npm run test:lighthouse

# Run cross-browser tests
npm run test:browsers
```

## 📁 Project Structure

```
.
├── css/                    # Stylesheets
│   ├── main.css           # Main styles
│   └── normalize.css      # CSS reset
├── js/                    # JavaScript files
│   ├── main.js           # Main application logic
│   └── vendor/           # Third-party libraries
├── img/                   # Images and assets
├── doc/                   # Documentation
├── .github/               # GitHub Actions workflows
│   └── workflows/
│       ├── ci-cd.yml     # Continuous deployment
│       ├── ci.yml        # Continuous integration
│       ├── pr-checks.yml # Pull request validation
│       └── security-scan.yml # Security scanning
├── index.html            # Main HTML file
├── 404.html              # Custom 404 page
├── robots.txt            # Search engine instructions
├── site.webmanifest      # PWA manifest
└── README.md             # This file
```

## 🔧 Configuration Files

- **`.prettierrc`**: Code formatting configuration
- **`.htmlhintrc`**: HTML linting rules
- **`.gitignore`**: Git ignore patterns
- **`browserconfig.xml`**: Browser configuration
- **`CNAME`**: Custom domain configuration

## 🌐 Deployment

The site is automatically deployed to GitHub Pages using GitHub Actions:

1. **Continuous Integration**: All code changes trigger comprehensive testing
2. **Quality Gates**: Deployment only occurs after passing all quality checks
3. **Security Scanning**: Regular vulnerability assessments
4. **Performance Monitoring**: Lighthouse audits on every deployment

## 🤝 Contributing

While this is a personal portfolio, suggestions and feedback are welcome!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE.txt](LICENSE.txt) file for details.

## 📞 Connect

- **🌐 Website**: [www.gdks.co.uk](https://www.gdks.co.uk)
- **💼 LinkedIn**: [linkedin.com/in/gavinstewart](https://www.linkedin.com/in/gavinstewart)
- **👨‍💻 GitHub**: [github.com/gdks](https://github.com/gdks)

## 🙏 Acknowledgments

- Built with HTML5 Boilerplate
- Icons by Font Awesome
- Typography by Google Fonts
- Hosted on GitHub Pages

---

<div align="center">
  <strong>⚡ Crafted with passion in Edinburgh, Scotland 🏴󠁧󠁢󠁳󠁣󠁴󠁿</strong>
</div>