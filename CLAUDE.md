# CLAUDE.md

Public Homebrew tap for **Nét** (`vodongnhut/homebrew-net`). Personal project of Nhựt Võ; identities and the `gh auth switch` rule are in `../CLAUDE.md`. Read it first.

## What is here

- `Casks/net.rb` — the only cask. Installs the release ZIP from `vodongnhut/net-releases`.
- `README.md` — user-facing install instructions. Keep it consistent with the cask `caveats`.

Users install with `brew install --cask vodongnhut/net/net` then `xattr -dr com.apple.quarantine "/Applications/Nét.app"`.

## Rules

- **Source of truth is not this repo.** `Casks/net.rb` is a copy of `../ai-writing-assistant/packaging/homebrew/net.rb`. Edit the template there, then copy it here; never hand-edit only this copy.
- A release bump changes exactly two lines: `version` and `sha256`. The sha256 comes from `SHA256SUMS` in `../ai-writing-assistant/dist/releases/<ver>/arm64/local/` (printed by `scripts/release_app.py`), and must match the ZIP attached to the GitHub release `v<ver>` in `net-releases`.
- Builds are ad-hoc signed arm64 previews, so the archive name is `Net-<ver>-arm64-local.zip` and the quarantine caveat stays. When notarized builds ship, drop the `-local` suffix and caveat and restore the per-arch `sha256` form (see the comment block at the top of the cask).
- Commit message convention: `Update net cask to <ver>`.
- Push only via the personal identity. The publish script in `../publish-net-<ver>.sh` pushes this repo after the GitHub release exists, then runs the audit below; do not push the cask before the release asset is live or `brew install` breaks.

## Verify

```sh
brew update --quiet
brew audit --cask --strict --online vodongnhut/net/net
brew style Casks/net.rb
```
