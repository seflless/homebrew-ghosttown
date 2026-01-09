#!/bin/bash
set -e

VERSION="${1:-}"
if [ -z "$VERSION" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

# Strip 'v' prefix if present
VERSION="${VERSION#v}"

# Download tarball and calculate SHA256
TARBALL_URL="https://registry.npmjs.org/@seflless/ghosttown/-/ghosttown-${VERSION}.tgz"
SHA256=$(curl -sL "$TARBALL_URL" | shasum -a 256 | cut -d' ' -f1)

# Check for empty tarball (hash of empty input)
if [ -z "$SHA256" ] || [ "$SHA256" = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855" ]; then
  echo "Failed to download tarball or calculate SHA256"
  exit 1
fi

echo "Updating formula to version ${VERSION} with SHA256: ${SHA256}"

# Update formula
cat > Formula/ghosttown.rb << FORMULA
class Ghosttown < Formula
  desc "Web-based terminal emulator using Ghostty's VT100 parser"
  homepage "https://github.com/coder/ghostty-web"
  url "https://registry.npmjs.org/@seflless/ghosttown/-/ghosttown-${VERSION}.tgz"
  sha256 "${SHA256}"
  license "MIT"

  depends_on "node"
  depends_on "python" => :build

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def caveats
    <<~EOS
      ghosttown requires tmux for session management features.
      Install it with: brew install tmux
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ghosttown --version")
  end
end
FORMULA

echo "Formula updated successfully!"
