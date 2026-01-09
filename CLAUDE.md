# CLAUDE.md

This is the Homebrew tap for [ghosttown](https://github.com/seflless/ghosttown), a web-based terminal emulator.

## How This Works

This tap is **mostly automated** - you rarely need to touch it directly.

### The Flow

1. **You release a new version** of ghosttown (via `bun cli:publish` or pushing a `v*` tag)
2. **The ghosttown repo's workflow** triggers this repo's `update-formula.yml` workflow
3. **This repo's workflow** downloads the new npm tarball, calculates its SHA256, and updates `Formula/ghosttown.rb`
4. **Users run** `brew upgrade ghosttown` to get the new version

### What the Formula Does

The formula at `Formula/ghosttown.rb`:
- Points to the npm tarball on `registry.npmjs.org`
- Installs Node.js as a dependency
- Runs `npm install` to install ghosttown globally
- Symlinks the CLI binaries (ghosttown, gt, ght)

### User Installation

```bash
# Install (auto-taps on first use)
brew install seflless/ghosttown/ghosttown

# Update to latest
brew upgrade ghosttown
```

## When You Might Need to Touch This Repo

- **Formula changes**: If you need to modify dependencies, caveats, or install behavior
- **Workflow issues**: If the auto-update fails for some reason
- **Manual trigger**: You can manually run the workflow from GitHub Actions with a version number

## Files

| File | Purpose |
|------|---------|
| `Formula/ghosttown.rb` | The Homebrew formula (auto-updated) |
| `.github/workflows/update-formula.yml` | Workflow triggered by ghosttown releases |
| `.github/scripts/update-formula.sh` | Script that updates the formula |
| `install.sh` | One-liner install script for curl piping |

## Manual Workflow Trigger

If needed, you can trigger an update manually:

```bash
curl -X POST \
  -H "Authorization: token YOUR_GITHUB_TOKEN" \
  https://api.github.com/repos/seflless/homebrew-ghosttown/dispatches \
  -d '{"event_type":"release","client_payload":{"version":"1.5.0"}}'
```

Or use the GitHub Actions UI: Actions → Update Formula → Run workflow → Enter version.

## Future: homebrew-core

When ghosttown is public and has traction, you can submit to homebrew-core for `brew install ghosttown` (without the tap prefix). The formula here serves as a tested starting point.

Resources:
- [Adding Software to Homebrew](https://docs.brew.sh/Adding-Software-to-Homebrew)
- [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook)
