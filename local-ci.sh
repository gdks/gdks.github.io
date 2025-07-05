#!/bin/bash

# Local CI Testing Framework
# Run GitHub Actions workflows locally for fast feedback

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
ACT_PLATFORM="ubuntu-latest=ghcr.io/catthehacker/ubuntu:act-latest"

print_usage() {
    echo -e "${BLUE}Local CI Testing Framework${NC}"
    echo ""
    echo "Usage: $0 [options] [workflow|job]"
    echo ""
    echo "Options:"
    echo "  -h, --help           Show this help message"
    echo "  -l, --list           List available workflows and jobs"
    echo "  -v, --verbose        Enable verbose output"
    echo "  -n, --dry-run        Show what would be executed without running"
    echo ""
    echo "Workflows:"
    echo "  pr-checks           Run PR validation checks (fast)"
    echo "  ci                  Run full CI pipeline"
    echo "  security            Run security scans"
    echo "  cd                  Run CI/CD pipeline (includes deployment)"
    echo ""
    echo "Individual Jobs:"
    echo "  code-quality        Run linting and formatting checks"
    echo "  html-validation     Run HTML validation"
    echo "  security-scan       Run security scans"
    echo "  web-standards       Run accessibility tests"
    echo "  lighthouse          Run performance tests"
    echo "  cross-browser       Run cross-browser tests"
    echo ""
    echo "Examples:"
    echo "  $0 pr-checks        # Run PR checks (recommended for development)"
    echo "  $0 code-quality     # Run only linting checks"
    echo "  $0 --list           # Show all available jobs"
}

list_jobs() {
    echo -e "${BLUE}Available Workflows:${NC}"
    echo "  📋 pr-checks       - Quick PR validation (HTML, CSS, JS linting, security)"
    echo "  🔧 ci              - Full CI pipeline (all tests except deployment)"
    echo "  🔒 security        - Security scans (Trivy, TruffleHog, OWASP ZAP)"
    echo "  🚀 cd              - Full CI/CD pipeline (includes deployment)"
    echo ""
    echo -e "${BLUE}Individual Jobs:${NC}"
    echo "  🧹 code-quality    - HTML/CSS/JS linting and formatting"
    echo "  ✅ html-validation - HTML5 validation"
    echo "  🔐 security-scan   - Vulnerability and secret scanning"
    echo "  ♿ web-standards   - Accessibility testing (axe-core, pa11y)"
    echo "  ⚡ lighthouse      - Performance and SEO testing"
    echo "  🌐 cross-browser   - Cross-browser testing with Playwright"
}

run_workflow() {
    local workflow=$1
    local verbose=$2
    local dry_run=$3
    
    local act_args="--platform $ACT_PLATFORM"
    
    if [[ $verbose == "true" ]]; then
        act_args="$act_args --verbose"
    fi
    
    if [[ $dry_run == "true" ]]; then
        act_args="$act_args --dryrun"
    fi
    
    case $workflow in
        "pr-checks")
            echo -e "${GREEN}Running PR Checks...${NC}"
            act pull_request $act_args --workflows .github/workflows/pr-checks.yml
            ;;
        "ci")
            echo -e "${GREEN}Running CI Pipeline...${NC}"
            act pull_request $act_args --workflows .github/workflows/ci.yml
            ;;
        "security")
            echo -e "${GREEN}Running Security Scans...${NC}"
            act workflow_dispatch $act_args --workflows .github/workflows/security-scan.yml
            ;;
        "cd")
            echo -e "${GREEN}Running CI/CD Pipeline...${NC}"
            act push $act_args --workflows .github/workflows/ci-cd.yml
            ;;
        *)
            echo -e "${RED}Unknown workflow: $workflow${NC}"
            echo "Use --list to see available workflows"
            exit 1
            ;;
    esac
}

run_job() {
    local job=$1
    local verbose=$2
    local dry_run=$3
    
    local act_args="--platform $ACT_PLATFORM"
    
    if [[ $verbose == "true" ]]; then
        act_args="$act_args --verbose"
    fi
    
    if [[ $dry_run == "true" ]]; then
        act_args="$act_args --dryrun"
    fi
    
    case $job in
        "code-quality")
            echo -e "${GREEN}Running Code Quality Checks...${NC}"
            act pull_request $act_args --workflows .github/workflows/pr-checks.yml --job pr-validation
            ;;
        "html-validation")
            echo -e "${GREEN}Running HTML Validation...${NC}"
            act pull_request $act_args --workflows .github/workflows/pr-checks.yml --job html-validation
            ;;
        "security-scan")
            echo -e "${GREEN}Running Security Scan...${NC}"
            act pull_request $act_args --workflows .github/workflows/pr-checks.yml --job basic-security
            ;;
        "web-standards")
            echo -e "${GREEN}Running Web Standards Tests...${NC}"
            act pull_request $act_args --workflows .github/workflows/ci.yml --job web-standards
            ;;
        "lighthouse")
            echo -e "${GREEN}Running Lighthouse Tests...${NC}"
            act pull_request $act_args --workflows .github/workflows/ci.yml --job lighthouse
            ;;
        "cross-browser")
            echo -e "${GREEN}Running Cross-browser Tests...${NC}"
            act pull_request $act_args --workflows .github/workflows/ci.yml --job cross-browser-test
            ;;
        *)
            echo -e "${RED}Unknown job: $job${NC}"
            echo "Use --list to see available jobs"
            exit 1
            ;;
    esac
}

# Parse command line arguments
VERBOSE=false
DRY_RUN=false
ACTION=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            print_usage
            exit 0
            ;;
        -l|--list)
            list_jobs
            exit 0
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -n|--dry-run)
            DRY_RUN=true
            shift
            ;;
        *)
            if [[ -z $ACTION ]]; then
                ACTION=$1
            else
                echo -e "${RED}Unknown option: $1${NC}"
                print_usage
                exit 1
            fi
            shift
            ;;
    esac
done

# Main execution
if [[ -z $ACTION ]]; then
    echo -e "${YELLOW}No action specified. Running default PR checks...${NC}"
    ACTION="pr-checks"
fi

echo -e "${BLUE}Local CI Testing Framework${NC}"
echo "=================================="

# Check if act is installed
if ! command -v act &> /dev/null; then
    echo -e "${RED}Error: 'act' is not installed.${NC}"
    echo "Please install it from: https://github.com/nektos/act"
    exit 1
fi

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo -e "${YELLOW}Warning: Docker is not running or not accessible.${NC}"
    echo "act requires Docker to run workflows locally."
    echo "Please start Docker and try again."
    exit 1
fi

# Determine if it's a workflow or job
case $ACTION in
    "pr-checks"|"ci"|"security"|"cd")
        run_workflow $ACTION $VERBOSE $DRY_RUN
        ;;
    "code-quality"|"html-validation"|"security-scan"|"web-standards"|"lighthouse"|"cross-browser")
        run_job $ACTION $VERBOSE $DRY_RUN
        ;;
    *)
        echo -e "${RED}Unknown action: $ACTION${NC}"
        print_usage
        exit 1
        ;;
esac

echo -e "${GREEN}Local CI execution completed!${NC}"