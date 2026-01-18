class Ghosttown < Formula
  desc "Web-based terminal emulator using Ghostty's VT100 parser"
  homepage "https://github.com/coder/ghostty-web"
  url "https://registry.npmjs.org/@seflless/ghosttown/-/ghosttown-1.9.1.tgz"
  sha256 "b7cd9539f1ae198b48820ab8aaf44dcacd2c60e33f62997af78e7e680b18c338"
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
