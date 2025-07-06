#!/bin/bash
set -e

# Install project dependencies
echo "Installing project dependencies..."
npm install

# Set up development environment
echo "Setting up development environment..."

# Create a simple development script
cat > /workspaces/gdks.github.io/dev.sh << 'EOF'
#!/bin/bash
echo "Starting development server..."
live-server --port=5500 --host=0.0.0.0 --no-browser
EOF

chmod +x /workspaces/gdks.github.io/dev.sh

echo "Development environment setup complete!"
echo "Run './dev.sh' to start the development server"
