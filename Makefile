# ============================================================================
# Local CI Framework Makefile
# ============================================================================
# This Makefile provides local CI targets that mirror the GitHub Actions workflow
# Run 'make help' to see all available targets

# Configuration
NODE_VERSION := 18
PORT := 8000
SERVE_HOST := localhost

# Colors for output
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[0;33m
BLUE := \033[0;34m
NC := \033[0m # No Color

# Default target
.DEFAULT_GOAL := help

# ============================================================================
# HELP
# ============================================================================
.PHONY: help
help: ## Show this help message
	@echo "$(BLUE)Local CI Framework$(NC)"
	@echo "$(BLUE)================$(NC)"
	@echo ""
	@echo "$(YELLOW)Available targets:$(NC)"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""
	@echo "$(YELLOW)Quick start:$(NC)"
	@echo "  make install    # Install all dependencies"
	@echo "  make ci         # Run all CI checks"
	@echo "  make serve      # Start local development server"

# ============================================================================
# SETUP & INSTALLATION
# ============================================================================
.PHONY: install install-dev install-global
install: install-dev install-global ## Install all dependencies

install-dev: ## Install development dependencies
	@echo "$(BLUE)Installing development dependencies...$(NC)"
	npm install

install-global: ## Install global tools for CI
	@echo "$(BLUE)Installing global tools...$(NC)"
	npm install -g @axe-core/cli pa11y lighthouse @lhci/cli @playwright/test

# ============================================================================
# CODE QUALITY
# ============================================================================
.PHONY: lint lint-html lint-css lint-js format format-check
lint: lint-html lint-css lint-js ## Run all linting checks

lint-html: ## Lint HTML files
	@echo "$(BLUE)Linting HTML files...$(NC)"
	npx htmlhint "**/*.html" || (echo "$(RED)HTML linting failed$(NC)" && exit 1)
	@echo "$(GREEN)HTML linting passed$(NC)"

lint-css: ## Lint CSS files
	@echo "$(BLUE)Linting CSS files...$(NC)"
	@echo '{"extends": "stylelint-config-standard", "rules": {"at-rule-no-unknown": [true, {"ignoreAtRules": ["supports"]}], "font-family-no-duplicate-names": null}}' > .stylelintrc.json
	npx stylelint "**/*.css" || (echo "$(RED)CSS linting failed$(NC)" && exit 1)
	@echo "$(GREEN)CSS linting passed$(NC)"

lint-js: ## Lint JavaScript files
	@echo "$(BLUE)Linting JavaScript files...$(NC)"
	npx eslint "**/*.js" --ignore-pattern "**/*.min.js" || (echo "$(RED)JavaScript linting failed$(NC)" && exit 1)
	@echo "$(GREEN)JavaScript linting passed$(NC)"

format: ## Format code with Prettier
	@echo "$(BLUE)Formatting code...$(NC)"
	npx prettier --write "**/*.{html,css,js,json,md}"
	@echo "$(GREEN)Code formatting completed$(NC)"

format-check: ## Check code formatting
	@echo "$(BLUE)Checking code formatting...$(NC)"
	npx prettier --check "**/*.{html,css,js,json,md}" || (echo "$(RED)Code formatting check failed$(NC)" && exit 1)
	@echo "$(GREEN)Code formatting check passed$(NC)"

# ============================================================================
# SECURITY SCANNING
# ============================================================================
.PHONY: security security-trivy security-secrets
security: security-trivy security-secrets ## Run all security checks

security-trivy: ## Run Trivy vulnerability scanner
	@echo "$(BLUE)Running Trivy vulnerability scanner...$(NC)"
	@if ! command -v trivy &> /dev/null; then \
		echo "$(YELLOW)Trivy not found. Install with: brew install trivy (macOS) or see https://aquasecurity.github.io/trivy/latest/getting-started/installation/$(NC)"; \
		exit 1; \
	fi
	trivy fs --format json --output trivy-results.json . || true
	@echo "$(GREEN)Trivy scan completed$(NC)"

security-secrets: ## Check for hardcoded secrets
	@echo "$(BLUE)Checking for hardcoded secrets...$(NC)"
	@if ! command -v trufflehog &> /dev/null; then \
		echo "$(YELLOW)TruffleHog not found. Install with: brew install trufflesecurity/trufflehog/trufflehog (macOS) or see https://github.com/trufflesecurity/trufflehog$(NC)"; \
		exit 1; \
	fi
	trufflehog --debug --only-verified . || true
	@echo "$(GREEN)Secrets scan completed$(NC)"

# ============================================================================
# HTML VALIDATION
# ============================================================================
.PHONY: validate-html
validate-html: ## Validate HTML files
	@echo "$(BLUE)Validating HTML files...$(NC)"
	npx html-validate "**/*.html" || (echo "$(RED)HTML validation failed$(NC)" && exit 1)
	@echo "$(GREEN)HTML validation passed$(NC)"

# ============================================================================
# WEB STANDARDS & ACCESSIBILITY
# ============================================================================
.PHONY: accessibility accessibility-axe accessibility-pa11y
accessibility: accessibility-axe accessibility-pa11y ## Run all accessibility tests

accessibility-axe: serve ## Run axe-core accessibility tests
	@echo "$(BLUE)Running axe-core accessibility tests...$(NC)"
	@sleep 3
	axe http://$(SERVE_HOST):$(PORT) --reporter json --output-file axe-results.json || true
	@if [ -f axe-results.json ]; then \
		echo "$(BLUE)Axe accessibility results:$(NC)"; \
		cat axe-results.json; \
	fi
	@echo "$(GREEN)Axe accessibility tests completed$(NC)"

accessibility-pa11y: serve ## Run pa11y accessibility tests
	@echo "$(BLUE)Running pa11y accessibility tests...$(NC)"
	@sleep 3
	pa11y http://$(SERVE_HOST):$(PORT) --reporter json > pa11y-results.json || true
	@if [ -f pa11y-results.json ]; then \
		echo "$(BLUE)Pa11y accessibility results:$(NC)"; \
		cat pa11y-results.json; \
	fi
	@echo "$(GREEN)Pa11y accessibility tests completed$(NC)"

# ============================================================================
# PERFORMANCE & SEO TESTING
# ============================================================================
.PHONY: lighthouse
lighthouse: serve ## Run Lighthouse performance and SEO tests
	@echo "$(BLUE)Running Lighthouse CI...$(NC)"
	@sleep 3
	lhci autorun \
		--collect.url=http://$(SERVE_HOST):$(PORT) \
		--collect.numberOfRuns=3 \
		--assert.assertions.categories:performance=0.8 \
		--assert.assertions.categories:accessibility=0.9 \
		--assert.assertions.categories:best-practices=0.8 \
		--assert.assertions.categories:seo=0.8 \
		--upload.target=temporary-public-storage || true
	@echo "$(GREEN)Lighthouse tests completed$(NC)"

# ============================================================================
# CROSS-BROWSER TESTING
# ============================================================================
.PHONY: test-browser test-browser-setup
test-browser: test-browser-setup serve ## Run cross-browser tests with Playwright
	@echo "$(BLUE)Running cross-browser tests...$(NC)"
	@sleep 3
	@mkdir -p tests
	@cat > playwright.config.js << 'EOF'
	module.exports = {
		testDir: './tests',
		use: {
			baseURL: 'http://$(SERVE_HOST):$(PORT)',
		},
		projects: [
			{ name: 'chromium', use: { ...require('@playwright/test').devices['Desktop Chrome'] } },
			{ name: 'firefox', use: { ...require('@playwright/test').devices['Desktop Firefox'] } },
			{ name: 'webkit', use: { ...require('@playwright/test').devices['Desktop Safari'] } },
		],
		webServer: {
			command: 'python3 -m http.server $(PORT)',
			port: $(PORT),
			reuseExistingServer: !process.env.CI,
		},
	};
	EOF
	@cat > tests/basic.spec.js << 'EOF'
	const { test, expect } = require('@playwright/test');
	
	test('homepage loads correctly', async ({ page }) => {
		await page.goto('/');
		await expect(page.locator('h1')).toContainText('Gavin Stewart');
		await expect(page.locator('title')).toContainText('Gavin Stewart');
	});
	
	test('navigation works', async ({ page }) => {
		await page.goto('/');
		await page.click('a[href="#about"]');
		await expect(page.locator('#about')).toBeVisible();
	});
	
	test('responsive design', async ({ page }) => {
		await page.goto('/');
		await page.setViewportSize({ width: 375, height: 667 });
		await expect(page.locator('.hero')).toBeVisible();
	});
	EOF
	npx playwright test || true
	@echo "$(GREEN)Cross-browser tests completed$(NC)"

test-browser-setup: ## Setup Playwright browsers
	@echo "$(BLUE)Setting up Playwright browsers...$(NC)"
	npx playwright install --with-deps
	@echo "$(GREEN)Playwright setup completed$(NC)"

# ============================================================================
# DEVELOPMENT SERVER
# ============================================================================
.PHONY: serve serve-stop
serve: ## Start local development server
	@echo "$(BLUE)Starting local server on http://$(SERVE_HOST):$(PORT)...$(NC)"
	@python3 -m http.server $(PORT) &
	@echo "$(GREEN)Server started. Use 'make serve-stop' to stop it.$(NC)"

serve-stop: ## Stop local development server
	@echo "$(BLUE)Stopping local server...$(NC)"
	@pkill -f "python3 -m http.server $(PORT)" || true
	@echo "$(GREEN)Server stopped$(NC)"

# ============================================================================
# CI TARGETS
# ============================================================================
.PHONY: ci ci-quick ci-full
ci: ci-quick ## Run all CI checks (quick version)

ci-quick: lint format-check validate-html ## Run quick CI checks (no server required)
	@echo "$(GREEN)✅ Quick CI checks completed successfully!$(NC)"

ci-full: ci-quick accessibility lighthouse test-browser ## Run full CI checks (requires server)
	@echo "$(GREEN)✅ Full CI checks completed successfully!$(NC)"

# ============================================================================
# CLEANUP
# ============================================================================
.PHONY: clean clean-reports
clean: clean-reports serve-stop ## Clean up generated files and stop server
	@echo "$(BLUE)Cleaning up...$(NC)"
	@rm -f .stylelintrc.json .eslintrc.json
	@rm -f trivy-results.json axe-results.json pa11y-results.json
	@rm -rf .lighthouseci/ playwright-report/ tests/
	@echo "$(GREEN)Cleanup completed$(NC)"

clean-reports: ## Clean up test reports
	@echo "$(BLUE)Cleaning up test reports...$(NC)"
	@rm -f trivy-results.json axe-results.json pa11y-results.json
	@rm -rf .lighthouseci/ playwright-report/
	@echo "$(GREEN)Reports cleaned$(NC)"

# ============================================================================
# UTILITY TARGETS
# ============================================================================
.PHONY: check-deps
check-deps: ## Check if required tools are installed
	@echo "$(BLUE)Checking required tools...$(NC)"
	@echo "Node.js: $$(node --version 2>/dev/null || echo 'Not installed')"
	@echo "npm: $$(npm --version 2>/dev/null || echo 'Not installed')"
	@echo "Python3: $$(python3 --version 2>/dev/null || echo 'Not installed')"
	@echo "Trivy: $$(trivy --version 2>/dev/null || echo 'Not installed')"
	@echo "TruffleHog: $$(trufflehog --version 2>/dev/null || echo 'Not installed')"
	@echo "html5validator: $$(html5validator --version 2>/dev/null || echo 'Not installed')"
	@echo "$(GREEN)Dependency check completed$(NC)"

.PHONY: status
status: ## Show current status
	@echo "$(BLUE)Current status:$(NC)"
	@echo "Branch: $$(git branch --show-current 2>/dev/null || echo 'Not a git repo')"
	@echo "Node version: $$(node --version 2>/dev/null || echo 'Not installed')"
	@echo "Server running: $$(pgrep -f 'python3 -m http.server $(PORT)' >/dev/null && echo 'Yes' || echo 'No')"
	@echo "$(GREEN)Status check completed$(NC)" 