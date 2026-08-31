cask "akv" do
  arch arm: "arm64", intel: "amd64"
  os macos: "macos", linux: "linux"

  version "1.0.0"
  sha256 arm: "5218e848dabe76fee4c755883c7af14a1d089ce2e0aaf5fed6369f4b29777b1c",
         arm64_linux: "2818b7a5079f03f6a258fdf155c99cd88d7d4546686a1144c55c37ff61365b85",
         x86_64_linux: "84e517a2fb636db464b0a18bedffd0b2b1263f30fefb025386905ecf996c2bea"

  on_macos do
    depends_on arch: :arm64, macos: :sonoma
  end

  url "https://github.com/heaths/akv-cli-rs/releases/download/v#{version}/akv-#{os}-#{arch}.tar.gz"
  name "Azure Key Vault CLI"
  desc "Read and decrypt secrets, pass them securely to other commands, or inject them into configuration files"
  homepage "https://github.com/heaths/akv-cli-rs"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "akv"
  generate_completions_from_executable "akv", "completion", shells: [:bash, :fish, :pwsh, :zsh]
end
