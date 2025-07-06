#!/bin/bash

# Local Accessibility and Performance Testing Script
# Run accessibility and performance tests locally

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PORT=8000
SERVER_PID=""

echo -e "${BLUE}Local Accessibility & Performance Testing${NC}"
echo "========================================"

# Cleanup function
cleanup() {
    if [[ -n $SERVER_PID ]]; then
        echo -e "${YELLOW}Stopping local server...${NC}"
        kill $SERVER_PID 2>/dev/null || true
        wait $SERVER_PID 2>/dev/null || true
    fi
}

# Set up cleanup on script exit
trap cleanup EXIT

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}Error: Node.js is not installed.${NC}"
    echo "Please install Node.js 18+ to run accessibility tests."
    exit 1
fi

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Error: Python 3 is not installed.${NC}"
    echo "Please install Python 3 to run the local server."
    exit 1
fi

# Install testing tools
echo -e "${BLUE}Installing testing tools...${NC}"
npm install -g @axe-core/cli pa11y lighthouse @lhci/cli > /dev/null 2>&1

# Start local server
echo -e "${BLUE}Starting local server on port $PORT...${NC}"
python3 -m http.server $PORT > /dev/null 2>&1 &
SERVER_PID=$!

# Wait for server to start
sleep 3

# Check if server is running
if ! curl -s http://localhost:$PORT > /dev/null; then
    echo -e "${RED}Error: Local server failed to start${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Local server started at http://localhost:$PORT${NC}"

# Run Accessibility Testing with axe-core
echo -e "${BLUE}Running axe-core accessibility tests...${NC}"
if axe http://localhost:$PORT --reporter json --output-file axe-results.json; then
    echo -e "${GREEN}✅ axe-core accessibility tests completed${NC}"
    if [[ -f axe-results.json ]]; then
        violations=$(jq '.violations | length' axe-results.json 2>/dev/null || echo "unknown")
        if [[ $violations == "0" ]]; then
            echo -e "${GREEN}   No accessibility violations found!${NC}"
        else
            echo -e "${YELLOW}   Found $violations accessibility violations${NC}"
            echo -e "${YELLOW}   Check axe-results.json for details${NC}"
        fi
    fi
else
    echo -e "${YELLOW}⚠️  axe-core tests completed with warnings${NC}"
fi

# Run Accessibility Testing with pa11y
echo -e "${BLUE}Running pa11y accessibility tests...${NC}"
if pa11y http://localhost:$PORT --reporter json > pa11y-results.json; then
    echo -e "${GREEN}✅ pa11y accessibility tests completed${NC}"
    if [[ -f pa11y-results.json ]]; then
        issues=$(jq '. | length' pa11y-results.json 2>/dev/null || echo "unknown")
        if [[ $issues == "0" ]]; then
            echo -e "${GREEN}   No accessibility issues found!${NC}"
        else
            echo -e "${YELLOW}   Found $issues accessibility issues${NC}"
            echo -e "${YELLOW}   Check pa11y-results.json for details${NC}"
        fi
    fi
else
    echo -e "${YELLOW}⚠️  pa11y tests completed with warnings${NC}"
fi

# Run Lighthouse Performance Tests
echo -e "${BLUE}Running Lighthouse performance tests...${NC}"
if lhci autorun \
    --collect.url=http://localhost:$PORT \
    --collect.numberOfRuns=1 \
    --assert.assertions.categories:performance=0.8 \
    --assert.assertions.categories:accessibility=0.9 \
    --assert.assertions.categories:best-practices=0.8 \
    --assert.assertions.categories:seo=0.8 \
    --upload.target=temporary-public-storage; then
    echo -e "${GREEN}✅ Lighthouse performance tests passed${NC}"
else
    echo -e "${YELLOW}⚠️  Lighthouse tests completed with issues${NC}"
    echo -e "${YELLOW}   Check .lighthouseci/ directory for detailed reports${NC}"
fi

# Display results summary
echo -e "${BLUE}Test Results Summary${NC}"
echo "==================="

if [[ -f axe-results.json ]]; then
    echo -e "${BLUE}Axe-core Results:${NC}"
    echo "  Results saved to: axe-results.json"
fi

if [[ -f pa11y-results.json ]]; then
    echo -e "${BLUE}Pa11y Results:${NC}"
    echo "  Results saved to: pa11y-results.json"
fi

if [[ -d .lighthouseci ]]; then
    echo -e "${BLUE}Lighthouse Results:${NC}"
    echo "  Reports saved to: .lighthouseci/"
fi

echo -e "${GREEN}🎉 Accessibility and performance testing completed!${NC}"
echo -e "${BLUE}Open the result files to review detailed findings.${NC}"