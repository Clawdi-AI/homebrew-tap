cask "clawdi@beta" do
  arch arm: "arm64", intel: "x64"

  version "0.1.0-beta.7"
  sha256 arm:   "613ee60b002335f0b4a8aa6e29160e0519dc1f5066e825853b989cbcb929f572",
         intel: "a75e6f16faeb02cac094238211e9e19c54fdf653b4bddfdee41441a4e59971c5"

  url "https://github.com/Clawdi-AI/clawdi/releases/download/desktop-v#{version}/Clawdi-#{version}-darwin-#{arch}.dmg"
  name "Clawdi"
  desc "Desktop workspace for AI agents and their tools"
  homepage "https://clawdi.ai/"

  livecheck do
    url "https://github.com/Clawdi-AI/clawdi"
    regex(/^desktop-v?(\d+(?:\.\d+)+-beta\.\d+)$/i)
    strategy :github_releases do |json, regex|
      json.filter_map do |release|
        next if release["draft"] || !release["prerelease"]

        release["tag_name"]&.match(regex)&.[](1)
      end
    end
  end

  auto_updates true
  depends_on macos: :ventura

  app "Clawdi.app"
end
