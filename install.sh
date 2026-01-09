#!/bin/bash
set -e

echo "Installing ghosttown..."

# Check for Homebrew
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew first..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install ghosttown
brew install seflless/ghosttown/ghosttown

echo ""
echo "ghosttown installed successfully!"
echo "Run 'ghosttown' to start the web terminal server."
