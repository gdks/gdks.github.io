#!/bin/bash

# Local CI Setup Script
# Initialize and verify the local CI testing environment

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Local CI Testing Framework Setup${NC}"
echo "=================================="

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check version
check_version() {
    local cmd=$1
    local min_version=$2
    local current_version=$($cmd 2>&1 || echo "0.0.0")
    
    echo "  Current version: $current_version"
}

echo -e "${BLUE}Checking Prerequisites...${NC}"

# Check Docker
echo -n "🐳 Docker: "
if command_exists docker; then
    if docker info >/dev/null 2>&1; then
        echo -e "${GREEN}✅ Available and running${NC}"
        check_version "docker --version"
    else
        echo -e "${YELLOW}⚠️  Available but not running${NC}"
        echo -e "${YELLOW}   Please start Docker: sudo systemctl start docker${NC}"
    fi
else
    echo -e "${RED}❌ Not installed${NC}"
    echo -e "${YELLOW}   Install with: sudo apt-get install docker.io${NC}"
fi

# Check Node.js
echo -n "📦 Node.js: "
if command_exists node; then
    node_version=$(node --version)
    echo -e "${GREEN}✅ Available${NC}"
    echo "  Version: $node_version"
    
    # Check if version is 18+
    major_version=$(echo $node_version | sed 's/v\([0-9]*\).*/\1/')
    if [ "$major_version" -ge 18 ]; then
        echo -e "${GREEN}   Version requirement met (18+)${NC}"
    else
        echo -e "${YELLOW}   ⚠️  Version $node_version is below recommended 18+${NC}"
    fi
else
    echo -e "${RED}❌ Not installed${NC}"
    echo -e "${YELLOW}   Install Node.js 18+ from: https://nodejs.org${NC}"
fi

# Check npm
echo -n "📦 npm: "
if command_exists npm; then
    echo -e "${GREEN}✅ Available${NC}"
    check_version "npm --version"
else
    echo -e "${RED}❌ Not installed${NC}"
    echo -e "${YELLOW}   npm should come with Node.js${NC}"
fi

# Check Python
echo -n "🐍 Python 3: "
if command_exists python3; then
    echo -e "${GREEN}✅ Available${NC}"
    check_version "python3 --version"
else
    echo -e "${RED}❌ Not installed${NC}"
    echo -e "${YELLOW}   Install with: sudo apt-get install python3${NC}"
fi

# Check act
echo -n "🎬 act: "
if command_exists act; then
    echo -e "${GREEN}✅ Available${NC}"
    check_version "act --version"
else
    echo -e "${YELLOW}⚠️  Not installed${NC}"
    echo -e "${BLUE}   Installing act...${NC}"
    
    if curl -s https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash; then
        echo -e "${GREEN}   ✅ act installed successfully${NC}"
    else
        echo -e "${RED}   ❌ Failed to install act${NC}"
    fi
fi

# Check additional tools
echo -e "${BLUE}Checking Optional Tools...${NC}"

# Check jq (for parsing JSON results)
echo -n "🔧 jq: "
if command_exists jq; then
    echo -e "${GREEN}✅ Available${NC}"
else
    echo -e "${YELLOW}⚠️  Not installed (optional)${NC}"
    echo -e "${YELLOW}   Install with: sudo apt-get install jq${NC}"
    echo -e "${YELLOW}   Used for parsing accessibility test results${NC}"
fi

# Check curl
echo -n "🌐 curl: "
if command_exists curl; then
    echo -e "${GREEN}✅ Available${NC}"
else
    echo -e "${RED}❌ Not installed${NC}"
    echo -e "${YELLOW}   Install with: sudo apt-get install curl${NC}"
fi

echo -e "${BLUE}Setting up Local CI Framework...${NC}"

# Make scripts executable
echo "📝 Making scripts executable..."
chmod +x local-ci.sh scripts/*.sh
echo -e "${GREEN}   ✅ Scripts are now executable${NC}"

# Create directories for results
echo "📁 Creating result directories..."
mkdir -p .lighthouseci
mkdir -p playwright-report
echo -e "${GREEN}   ✅ Result directories created${NC}"

# Test the framework
echo -e "${BLUE}Testing Framework...${NC}"
echo "🧪 Running framework test..."

if ./local-ci.sh --list >/dev/null 2>&1; then
    echo -e "${GREEN}   ✅ Framework test passed${NC}"
else
    echo -e "${RED}   ❌ Framework test failed${NC}"
    exit 1
fi

# Setup summary
echo -e "${BLUE}Setup Summary${NC}"
echo "=============="

echo -e "${GREEN}✅ Local CI Testing Framework is ready!${NC}"
echo ""
echo -e "${BLUE}Quick Start Commands:${NC}"
echo "  ./local-ci.sh --help           # Show help"
echo "  ./local-ci.sh --list           # List workflows"
echo "  ./local-ci.sh pr-checks        # Run PR checks"
echo "  ./scripts/local-lint.sh        # Quick linting"
echo ""
echo -e "${BLUE}Next Steps:${NC}"
echo "1. Run your first test: ./local-ci.sh pr-checks"
echo "2. Check the documentation: cat LOCAL_CI_SETUP.md"
echo "3. Set up IDE integration (see LOCAL_CI_SETUP.md)"
echo ""
echo -e "${YELLOW}Note: If you see Docker permission errors, run:${NC}"
echo -e "${YELLOW}  sudo usermod -aG docker \$USER${NC}"
echo -e "${YELLOW}  Then log out and back in.${NC}"

echo -e "${GREEN}🎉 Setup completed successfully!${NC}"