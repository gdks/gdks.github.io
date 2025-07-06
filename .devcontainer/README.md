# Development Container Setup

This project uses VS Code's Development Containers to provide a consistent development environment.

## Features

- **Node.js 18** - Latest LTS version for JavaScript development
- **Live Server** - Hot reload development server
- **Code Quality Tools**:
  - ESLint for JavaScript linting
  - HTMLHint for HTML validation
  - Stylelint for CSS linting
  - Prettier for code formatting
- **VS Code Extensions**:
  - Live Server for development server
  - Prettier for code formatting
  - HTML/CSS support
  - Auto rename tag
  - CSS peek

## Getting Started

1. Install [Docker](https://www.docker.com/products/docker-desktop/)
2. Install [VS Code](https://code.visualstudio.com/)
3. Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
4. Open this project in VS Code
5. When prompted, click "Reopen in Container"

## Development Commands

Once inside the container:

- `npm run dev` - Start the development server
- `npm run lint` - Run all linters
- `npm run format` - Format all code with Prettier

## Port Forwarding

The development server runs on port 5500 and is automatically forwarded to your host machine.

## File Structure

```
.devcontainer/
├── devcontainer.json    # VS Code devcontainer configuration
├── docker-compose.yml   # Docker services configuration
├── Dockerfile          # Container image definition
├── post-create.sh      # Post-creation setup script
└── README.md           # This file
```
