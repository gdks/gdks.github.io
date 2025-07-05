#!/bin/bash

# Local Code Formatting Script
# Automatically fix formatting issues

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Auto-fixing Code Formatting${NC}"
echo "=========================="

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}Error: Node.js is not installed.${NC}"
    echo "Please install Node.js 18+ to run formatting."
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo -e "${RED}Error: npm is not installed.${NC}"
    echo "Please install npm to run formatting."
    exit 1
fi

# Initialize package.json if it doesn't exist
if [[ ! -f package.json ]]; then
    echo -e "${YELLOW}Creating package.json...${NC}"
    npm init -y > /dev/null
fi

# Install prettier if not installed
if ! npm list prettier &> /dev/null; then
    echo -e "${BLUE}Installing prettier...${NC}"
    npm install --save-dev prettier > /dev/null 2>&1
fi

# Run Prettier to fix formatting
echo -e "${BLUE}Fixing code formatting...${NC}"
if npx prettier --write "**/*.{html,css,js,json,md}"; then
    echo -e "${GREEN}✅ Code formatting fixed!${NC}"
else
    echo -e "${RED}❌ Failed to fix formatting${NC}"
    exit 1
fi

echo -e "${GREEN}🎉 All formatting issues have been fixed!${NC}"