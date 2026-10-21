# Homebrew tap for Nét

Nét is a native macOS menu-bar writing assistant. This tap installs the release
builds published at <https://github.com/vodongnhut/net-releases>.

```sh
brew install --cask --no-quarantine vodongnhut/net/net
```

Current builds are ad-hoc signed and not notarized, so `--no-quarantine` is
required for Gatekeeper to let the app open. Apple silicon only for now.

After launching, grant Accessibility access in
System Settings > Privacy & Security > Accessibility. Each new build needs
to be granted again.
