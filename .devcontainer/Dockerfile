FROM mcr.microsoft.com/devcontainers/javascript-node:18

# Install additional tools for web development
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    unzip \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Install act for running GitHub Actions locally
RUN curl https://raw.githubusercontent.com/nektos/act/master/install.sh | bash

# Install global npm packages for web development
RUN npm install -g \
    live-server \
    prettier \
    eslint \
    htmlhint \
    stylelint

# Set working directory
WORKDIR /workspaces/gdks.github.io
