# Homebrew tap for Nét

Nét is a native macOS menu-bar writing assistant. This tap installs the release
builds published at <https://github.com/vodongnhut/net-releases>.

```sh
brew install --cask vodongnhut/net/net
xattr -dr com.apple.quarantine "/Applications/Nét.app"
```

Current builds are ad-hoc signed and not notarized, so Gatekeeper rejects the
quarantined download; the `xattr` line clears the flag once before the first
launch (Homebrew 7 removed `--no-quarantine`). Apple silicon only for now.

After launching, grant Accessibility access in
System Settings > Privacy & Security > Accessibility. Each new build needs
to be granted again.
