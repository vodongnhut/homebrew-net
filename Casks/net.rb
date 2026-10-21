# Homebrew cask template for Nét.
#
# This file is the source of truth kept next to the app code. Copy it to the
# public tap repository (vodongnhut/homebrew-net, path Casks/net.rb) after
# each release, filling in the version and the SHA-256 values printed by
# scripts/release_app.py. See docs/RELEASING.md, section "Homebrew tap".
#
# Users install with:
#   brew install --cask vodongnhut/net/net
#   xattr -dr com.apple.quarantine "/Applications/Nét.app"
#
# Current releases are ad-hoc signed `--local` previews for arm64 only, so the
# archive name carries the `-local` suffix and the quarantine flag must be
# cleared by hand (Homebrew 7 removed `--no-quarantine`).
# When notarized builds ship, drop the suffix and the Gatekeeper caveat, and
# restore the `arch arm:/intel:` form with one sha256 per architecture.
cask "net" do
  version "0.7.2"
  sha256 "2a2f33b097414a1bb9fba4351ae0a8bf7adcd08b28b7a956578a72e3ca32e516"

  url "https://github.com/vodongnhut/net-releases/releases/download/v#{version}/Net-#{version}-arm64-local.zip"
  name "Nét"
  desc "Menu-bar writing assistant that corrects or translates text via your AI endpoint"
  homepage "https://github.com/vodongnhut/net-releases"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  # Matches LSMinimumSystemVersion in scripts/build_app.py.
  depends_on macos: :ventura

  app "Nét.app"

  # Quit the running instance before upgrading so the per-user instance lock
  # and the status item are released cleanly.
  uninstall quit: "dev.nhutvo.ai-writing-assistant"

  # Only `brew uninstall --zap` removes user data. API keys live in the
  # Keychain and are never touched by Homebrew.
  zap trash: [
    "~/Library/Application Support/AI Writing Assistant",
    "~/Library/Preferences/dev.nhutvo.ai-writing-assistant.plist",
  ]

  caveats <<~EOS
    This build is ad-hoc signed and not notarized, so Gatekeeper blocks it
    after a quarantined download. Clear the flag once before the first launch:
      xattr -dr com.apple.quarantine "/Applications/Nét.app"

    Nét reads and replaces unsent Slack drafts only after you grant it
    Accessibility permission and enable Slack integration in its Settings.
    Both default to off. The "Translate with Nét" service is display-only.

    Open System Settings > Privacy & Security > Accessibility and add Nét
    after the first launch. Every new build must be added again.
  EOS
end
