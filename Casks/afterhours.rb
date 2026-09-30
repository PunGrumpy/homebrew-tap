cask "afterhours" do
  version "0.2.2"
  sha256 "5cda6c4e90d230e98f59fea9aeaefdef30b48851d4ca46fdf0fb163763f1de30"

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
