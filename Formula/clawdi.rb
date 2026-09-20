class Clawdi < Formula
  desc "CLI for managing Clawdi agents, runtimes, and sync"
  homepage "https://clawdi.ai"
  version "0.14.87"
  license "MIT"

  livecheck do
    url :stable
    regex(/^clawdi-cli-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases do |json, regex|
      json.filter_map do |release|
        next if release["draft"] || release["prerelease"]

        release["tag_name"]&.match(regex)&.[](1)
      end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/Clawdi-AI/clawdi/releases/download/clawdi-cli-v#{version}/clawdi-cli-darwin-arm64.tar.gz"
      sha256 "4d9b95e1ec3859204a56026bbf204a8f8e0bc3650a31040e5e838e756780afd7"
    end

    on_intel do
      url "https://github.com/Clawdi-AI/clawdi/releases/download/clawdi-cli-v#{version}/clawdi-cli-darwin-x64.tar.gz"
      sha256 "3dc9e05c202621170e43c636340592265726e6249b69c86cab5bc05d5e0abd76"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Clawdi-AI/clawdi/releases/download/clawdi-cli-v#{version}/clawdi-cli-linux-arm64.tar.gz"
      sha256 "a045e990b0deeb2f04f7c34c625e54b5f0883bb7c8f6ea18379ae6296b4af456"
    end

    on_intel do
      url "https://github.com/Clawdi-AI/clawdi/releases/download/clawdi-cli-v#{version}/clawdi-cli-linux-x64.tar.gz"
      sha256 "65ed460e36f20d732754c4a9e7ae0eb46a1673025ac8358377dc996a8a006e2c"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"clawdi"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/clawdi --version")
    assert_match '"managedBy": "homebrew"', shell_output("#{bin}/clawdi update --json")
  end
end
