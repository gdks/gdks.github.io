#!/bin/bash

# Local Linting Script
# Run the same linting checks as GitHub Actions but locally for fast feedback

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Local Linting Checks${NC}"
echo "===================="

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}Error: Node.js is not installed.${NC}"
    echo "Please install Node.js 18+ to run linting checks."
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo -e "${RED}Error: npm is not installed.${NC}"
    echo "Please install npm to run linting checks."
    exit 1
fi

# Initialize package.json if it doesn't exist
if [[ ! -f package.json ]]; then
    echo -e "${YELLOW}Creating package.json...${NC}"
    npm init -y > /dev/null
fi

# Install dependencies
echo -e "${BLUE}Installing linting dependencies...${NC}"
npm install --save-dev htmlhint stylelint stylelint-config-standard eslint prettier > /dev/null 2>&1

# Create configuration files
echo -e "${BLUE}Setting up linting configurations...${NC}"

# StyleLint configuration
cat > .stylelintrc.json << 'EOF'
{
  "extends": "stylelint-config-standard",
  "rules": {
    "at-rule-no-unknown": [
      true,
      {
        "ignoreAtRules": ["supports"]
      }
    ]
  }
}
EOF



# Run HTML Linting
echo -e "${BLUE}Running HTML Linting...${NC}"
if npx htmlhint "**/*.html"; then
    echo -e "${GREEN}✅ HTML linting passed${NC}"
else
    echo -e "${RED}❌ HTML linting failed${NC}"
    exit 1
fi

# Run CSS Linting
echo -e "${BLUE}Running CSS Linting...${NC}"
if npx stylelint "**/*.css"; then
    echo -e "${GREEN}✅ CSS linting passed${NC}"
else
    echo -e "${RED}❌ CSS linting failed${NC}"
    exit 1
fi

# Run JavaScript Linting
echo -e "${BLUE}Running JavaScript Linting...${NC}"
if npx eslint "**/*.js" --ignore-pattern "**/*.min.js"; then
    echo -e "${GREEN}✅ JavaScript linting passed${NC}"
else
    echo -e "${RED}❌ JavaScript linting failed${NC}"
    exit 1
fi

# Run Code Formatting Check
echo -e "${BLUE}Running Code Formatting Check...${NC}"
if npx prettier --check "**/*.{html,css,js,json,md}"; then
    echo -e "${GREEN}✅ Code formatting check passed${NC}"
else
    echo -e "${YELLOW}❌ Code formatting issues found${NC}"
    echo -e "${YELLOW}Run 'npx prettier --write \"**/*.{html,css,js,json,md}\"' to fix them${NC}"
    exit 1
fi

echo -e "${GREEN}🎉 All linting checks passed!${NC}"