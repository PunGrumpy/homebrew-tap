cask "peony" do
  version "0.3.0"
  sha256 "d17889f71e682be13d8845b7255f027ef8ba093d8c28549867659856cb3cd12c"

  url "https://github.com/PunGrumpy/peony/releases/download/%40peony/macos%40#{version}/Peony-#{version}.dmg"
  name "Peony"
  desc "Menu bar switcher that keeps one VPN on at a time"
  homepage "https://github.com/PunGrumpy/peony"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Peony.app"

  uninstall quit: "app.peony.Peony"

  zap delete: [
        "/etc/sudoers.d/peony",
        "/Library/PrivilegedHelperTools/app.peony.helper",
      ],
      trash:  [
        "~/Library/Application Support/Peony",
        "~/Library/Preferences/app.peony.Peony.plist",
      ]

  caveats <<~EOS
    Peony isn't notarized yet, so macOS blocks it the first time.
    Open System Settings > Privacy & Security and click Open Anyway.

    Peony drives command-line VPN clients. Install the ones you use:
      brew install openfortivpn        # FortiGate
      brew install openconnect         # AnyConnect, GlobalProtect, Pulse, F5
      brew install wireguard-tools     # WireGuard
  EOS
end
