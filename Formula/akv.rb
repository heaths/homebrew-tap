class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v1.0.0-beta.1.tar.gz"
  sha256 "d3e76d83cc4ee9b0ec6d12a3949ae47df0f5c7e23ea72fcccfe640ba10a40953"
  license "MIT"
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1bd583f430a9e867d8780e2afcad7c8219bba593e4ddb7fe12b4c554dd71f541"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bb96865ff74d2ac53e45d578bea9625f8ec7e8c9f84535bbeaafb5cba044cbad"
    sha256 cellar: :any,                 arm64_linux:   "75e93cf3e8b36e0a3c8fa74edd620ce1e415a033a41c34fa52a518c11614929e"
    sha256 cellar: :any,                 x86_64_linux:  "20b119e56b09dd336621004dad4975b1d11825bfced4cffb429f63ce03873d6d"
  end

  depends_on "rustup" => :build
  depends_on "openssl@3"

  def install
    system "rustup", "default", "nightly"
    ENV["OPENSSL_DIR"] = formula_opt_prefix("openssl@3")
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"akv", "completion", shells: [:bash, :fish, :pwsh, :zsh])
  end

  test do
    assert_match "akv #{version}", shell_output("#{bin}/akv --version")
  end
end
