# Homebrew Tap for ghosttown

This is a [Homebrew](https://brew.sh) tap for [ghosttown](https://github.com/coder/ghostty-web), a web-based terminal emulator using Ghostty's VT100 parser.

## Installation

```bash
brew install seflless/ghosttown/ghosttown
```

Or tap first:

```bash
brew tap seflless/ghosttown
brew install ghosttown
```

## Usage

```bash
# Start the web terminal server
ghosttown

# Open http://localhost:8080 in your browser
```

### Additional Commands

```bash
ghosttown --help          # Show help
ghosttown --version       # Show version
ghosttown -p 3000         # Use custom port
ghosttown list            # List tmux sessions
ghosttown attach <name>   # Attach to session
ghosttown -k              # Kill all sessions
```

## Requirements

- **Node.js** (installed automatically via Homebrew)
- **tmux** (optional, for session management)

Install tmux:

```bash
brew install tmux
```

## Links

- [ghosttown on npm](https://www.npmjs.com/package/@seflless/ghosttown)
- [GitHub Repository](https://github.com/coder/ghostty-web)
