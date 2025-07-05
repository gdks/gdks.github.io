# Local CI Testing Framework

This framework allows you to run your GitHub Actions workflows locally for fast feedback during development, eliminating the need to push commits to test CI changes.

## 🚀 Quick Start

### Prerequisites

1. **Docker** - Required for running workflows with `act`
2. **Node.js 18+** - Required for linting and testing tools
3. **Python 3** - Required for local web server

### Installation

The framework is already set up in this repository. To get started:

1. **Make scripts executable:**
   ```bash
   chmod +x local-ci.sh
   chmod +x scripts/*.sh
   ```

2. **Install Docker** (if not already installed):
   ```bash
   # Ubuntu/Debian
   sudo apt-get update
   sudo apt-get install docker.io
   sudo usermod -aG docker $USER
   # Log out and back in for group changes to take effect
   ```

3. **Test the setup:**
   ```bash
   ./local-ci.sh --list
   ```

## 📋 Available Commands

### Main Script: `./local-ci.sh`

#### Quick Commands
```bash
# Run PR checks (recommended for development)
./local-ci.sh pr-checks

# Run individual job types
./local-ci.sh code-quality      # Linting only
./local-ci.sh html-validation   # HTML validation
./local-ci.sh security-scan     # Security checks
./local-ci.sh web-standards     # Accessibility tests
./local-ci.sh lighthouse        # Performance tests
./local-ci.sh cross-browser     # Cross-browser tests

# Run full workflows
./local-ci.sh ci               # Full CI pipeline
./local-ci.sh security         # Security scans
./local-ci.sh cd               # CI/CD with deployment
```

#### Options
```bash
./local-ci.sh --list           # Show all available workflows and jobs
./local-ci.sh --help           # Show usage help
./local-ci.sh --verbose ci     # Run with verbose output
./local-ci.sh --dry-run ci     # Show what would run without executing
```

### Native Scripts (Faster for Development)

These scripts run checks natively without Docker, providing faster feedback:

```bash
# Quick linting (fastest)
./scripts/local-lint.sh

# Auto-fix formatting issues
./scripts/local-format.sh

# Accessibility and performance tests
./scripts/local-accessibility.sh
```

## 🔧 Workflow Details

### Available Workflows

| Workflow | Description | Use Case |
|----------|-------------|----------|
| `pr-checks` | Quick validation for PRs | **Development** - Fast feedback |
| `ci` | Full CI pipeline | **Pre-merge** - Comprehensive testing |
| `security` | Security scans | **Security review** - Vulnerability checks |
| `cd` | CI/CD with deployment | **Release** - Full pipeline with deploy |

### Individual Jobs

| Job | Description | Runtime |
|-----|-------------|---------|
| `code-quality` | HTML/CSS/JS linting + formatting | ~2-3 minutes |
| `html-validation` | HTML5 validation | ~1-2 minutes |
| `security-scan` | Secret scanning | ~3-5 minutes |
| `web-standards` | Accessibility testing | ~5-10 minutes |
| `lighthouse` | Performance & SEO testing | ~3-5 minutes |
| `cross-browser` | Cross-browser testing | ~10-15 minutes |

## 🏃‍♂️ Recommended Development Workflow

### 1. During Development
```bash
# Quick feedback loop
./scripts/local-lint.sh

# Fix formatting issues automatically
./scripts/local-format.sh
```

### 2. Before Creating PR
```bash
# Run PR checks
./local-ci.sh pr-checks
```

### 3. Before Merging
```bash
# Run full CI pipeline
./local-ci.sh ci
```

### 4. For Security Review
```bash
# Run security scans
./local-ci.sh security
```

## 🐛 Troubleshooting

### Common Issues

#### 1. Docker Permission Denied
```bash
# Add user to docker group
sudo usermod -aG docker $USER
# Log out and back in
```

#### 2. Port 8000 Already in Use
```bash
# Kill existing processes on port 8000
sudo lsof -ti:8000 | xargs kill
```

#### 3. Node.js Dependencies Issues
```bash
# Clean and reinstall
rm -rf node_modules package-lock.json
npm install
```

#### 4. Act Not Found
```bash
# Reinstall act
curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash
```

### Debug Mode

Run with verbose output to see detailed execution:
```bash
./local-ci.sh --verbose pr-checks
```

### Dry Run Mode

See what would be executed without actually running:
```bash
./local-ci.sh --dry-run ci
```

## 📊 Understanding Results

### Linting Results
- ✅ **Green**: All checks passed
- ❌ **Red**: Issues found - need fixing
- ⚠️ **Yellow**: Warnings - review recommended

### Accessibility Results
- Results saved to `axe-results.json` and `pa11y-results.json`
- Zero violations = perfect accessibility score
- Review detailed reports for improvement areas

### Performance Results
- Lighthouse reports saved to `.lighthouseci/` directory
- Scores: Performance (80%+), Accessibility (90%+), Best Practices (80%+), SEO (80%+)
- Open HTML reports in browser for detailed insights

## 🔄 Integration with IDE

### VS Code Integration

Add to `.vscode/tasks.json`:
```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Local CI: PR Checks",
            "type": "shell",
            "command": "./local-ci.sh pr-checks",
            "group": "test",
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": false,
                "panel": "shared"
            }
        },
        {
            "label": "Local CI: Lint",
            "type": "shell",
            "command": "./scripts/local-lint.sh",
            "group": "test"
        },
        {
            "label": "Local CI: Format",
            "type": "shell",
            "command": "./scripts/local-format.sh",
            "group": "build"
        }
    ]
}
```

### Git Hooks

Add to `.git/hooks/pre-commit`:
```bash
#!/bin/sh
echo "Running local linting..."
./scripts/local-lint.sh
```

## 📁 Generated Files

The framework creates several files during execution:

```
├── .actrc                     # Act configuration
├── .eslintrc.json            # ESLint configuration
├── .stylelintrc.json         # StyleLint configuration
├── package.json              # Node.js dependencies
├── axe-results.json          # Accessibility test results
├── pa11y-results.json        # Accessibility test results
├── .lighthouseci/            # Lighthouse reports
└── playwright-report/        # Cross-browser test reports
```

### Cleanup

To clean up generated files:
```bash
# Remove test results
rm -f axe-results.json pa11y-results.json
rm -rf .lighthouseci/ playwright-report/

# Remove Node.js files (optional)
rm -f package.json package-lock.json .eslintrc.json .stylelintrc.json
rm -rf node_modules/
```

## 🎯 Tips for Faster Development

1. **Use native scripts** for quick feedback during development
2. **Run PR checks** before creating pull requests
3. **Use --dry-run** to understand what tests will run
4. **Focus on failing jobs** using individual job commands
5. **Auto-fix formatting** regularly to avoid CI failures

## 🔗 Additional Resources

- [act Documentation](https://github.com/nektos/act)
- [HTMLHint Rules](https://htmlhint.com/docs/user-guide/list-rules)
- [StyleLint Rules](https://stylelint.io/user-guide/rules/list)
- [ESLint Rules](https://eslint.org/docs/rules/)
- [Prettier Options](https://prettier.io/docs/en/options.html)
- [axe-core Documentation](https://www.deque.com/axe/axe-for-web/)
- [Lighthouse CI](https://github.com/GoogleChrome/lighthouse-ci)

## 🤝 Contributing

To improve this framework:

1. Test changes with `./local-ci.sh --dry-run`
2. Update documentation for new features
3. Ensure backward compatibility
4. Add appropriate error handling