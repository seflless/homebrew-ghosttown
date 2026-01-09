# CLAUDE.md

This is the Homebrew tap for [ghosttown](https://github.com/seflless/ghosttown), a web-based terminal emulator.

## Installation Methods

### Method 1: Homebrew (Recommended)

```bash
brew install seflless/ghosttown/ghosttown
```

### Method 2: One-liner Script

```bash
curl -fsSL https://raw.githubusercontent.com/seflless/homebrew-ghosttown/main/install.sh | bash
```

### Method 3: npm

```bash
npm install -g @seflless/ghosttown
```

### Updating

```bash
# If installed via Homebrew
brew upgrade ghosttown

# If installed via npm
ghosttown update
# or
npm update -g @seflless/ghosttown
```

---

## How This Tap Works

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

---

## TODO: Get `brew install ghosttown` Working

Currently users must run `brew install seflless/ghosttown/ghosttown`. To enable the simpler `brew install ghosttown`, we need to submit to homebrew-core.

### Prerequisites

1. **Open source the ghosttown repo** - https://github.com/seflless/ghosttown must be public (homebrew-core requires open source projects)

2. **Build notability** - Homebrew looks for signs the project is actively used:
   - GitHub stars
   - npm download counts
   - Active issues/PRs
   - Documentation/website

### Submission Process

Once the prerequisites are met:

1. **Fork** [Homebrew/homebrew-core](https://github.com/Homebrew/homebrew-core)

2. **Set up local homebrew-core:**
   ```bash
   export HOMEBREW_NO_INSTALL_FROM_API=1
   brew tap --force homebrew/core
   ```

3. **Copy the formula** from this repo to homebrew-core:
   ```bash
   cp Formula/ghosttown.rb $(brew --repository homebrew/core)/Formula/g/ghosttown.rb
   ```

4. **Test the formula:**
   ```bash
   brew install --build-from-source ghosttown
   brew test ghosttown
   brew audit --new ghosttown
   brew audit --strict ghosttown
   ```

5. **Create a branch and commit:**
   ```bash
   cd $(brew --repository homebrew/core)
   git checkout -b ghosttown
   git add Formula/g/ghosttown.rb
   git commit -m "ghosttown 1.x.x (new formula)"
   ```

6. **Push to your fork and open a PR** to homebrew-core

### Resources

- [Adding Software to Homebrew](https://docs.brew.sh/Adding-Software-to-Homebrew) - Main submission guide
- [Formula Cookbook](https://docs.brew.sh/Formula-Cookbook) - Formula writing details  
- [Acceptable Formulae](https://docs.brew.sh/Acceptable-Formulae) - What Homebrew accepts
- [CONTRIBUTING.md](https://github.com/Homebrew/homebrew-core/blob/master/CONTRIBUTING.md) - Contribution guidelines

### After Acceptance

Once merged into homebrew-core:
- Users can run `brew install ghosttown` globally
- Homebrew's autobump will handle future version updates automatically
- This tap (`seflless/homebrew-ghosttown`) can remain as a backup or be archived
