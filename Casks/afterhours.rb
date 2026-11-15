cask "afterhours" do
  version "0.5.0"
  sha256 "c7b19cacef773d0f476a1436b3ccb22aa7f08e716d798bcc92faf30d1af5c2fe"

  url "https://github.com/PunGrumpy/afterhours/releases/download/%40afterhours/macos%40#{version}/Afterhours-#{version}.dmg"
  name "Afterhours"
  desc "Keep your Mac awake while coding agents work"
  homepage "https://tryafterhours.vercel.app/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Afterhours.app"

  uninstall quit: "app.afterhours.local"

  zap delete: "/etc/sudoers.d/afterhours",
      trash:  [
        "~/Library/Application Support/Afterhours",
        "~/Library/Preferences/app.afterhours.local.plist",
      ]

  caveats <<~EOS
    Afterhours isn't notarized yet, so macOS blocks it the first time.
    Open System Settings > Privacy & Security and click Open Anyway.

    Upgrading quits Afterhours, which lets a closed Mac sleep.
    Upgrade with the lid open.

    Before `brew uninstall --zap`, remove Claude Code hooks in
    Settings > Agents and hubs in Settings > Limits.
  EOS
end
