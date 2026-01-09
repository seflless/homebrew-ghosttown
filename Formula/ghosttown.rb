class Ghosttown < Formula
  desc "Web-based terminal emulator using Ghostty's VT100 parser"
  homepage "https://github.com/coder/ghostty-web"
  url "https://registry.npmjs.org/@seflless/ghosttown/-/ghosttown-1.4.0.tgz"
  sha256 "b31a498106f1928b3aaa32c8542a3ad33bf0876d2cc85661d93ef03b60bd50b5"
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
