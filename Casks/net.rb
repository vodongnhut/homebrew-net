# Homebrew cask template for Nét.
#
# This file is the source of truth kept next to the app code. Copy it to the
# public tap repository (vodongnhut/homebrew-net, path Casks/net.rb) after
# each release, filling in the version and the SHA-256 values printed by
# scripts/release_app.py. See docs/RELEASING.md, section "Homebrew tap".
#
# Users install with:
#   brew install --cask --no-quarantine vodongnhut/net/net
#
# Current releases are ad-hoc signed `--local` previews for arm64 only, so the
# archive name carries the `-local` suffix and `--no-quarantine` is required.
# When notarized builds ship, drop the suffix and the Gatekeeper caveat, and
# restore the `arch arm:/intel:` form with one sha256 per architecture.
cask "net" do
  version "0.7.0"
  sha256 "10e8de35913523c81096e66355ff8fb87c460500905e9d7996f5127b1346a84d"

  url "https://github.com/vodongnhut/net-releases/releases/download/v#{version}/Net-#{version}-arm64-local.zip",
      verified: "github.com/vodongnhut/net-releases/"
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
    after a quarantined download. Install with
      brew install --cask --no-quarantine vodongnhut/net/net
    or clear the flag afterwards with
      xattr -dr com.apple.quarantine "/Applications/Nét.app"

    Nét reads and replaces unsent Slack drafts only after you grant it
    Accessibility permission and enable Slack integration in its Settings.
    Both default to off. The "Translate with Nét" service is display-only.

    Open System Settings > Privacy & Security > Accessibility and add Nét
    after the first launch. Every new build must be added again.
  EOS
end
