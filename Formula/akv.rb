class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.11.1.tar.gz"
  sha256 "420ffaef6fdf0359fb5308111a1698fa5654cba05c91b1714caac21bfbfb037f"
  license "MIT"
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5f251fb963ece6696b14a076766364f462bacdb8d764caf93eb3861c638d62d6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fa27b62d55c1f7ecacb0f5709530fe423112562841502c04f00fa3b94b7aed73"
    sha256 cellar: :any,                 arm64_linux:   "2e2e30fd47a1283e64652e73bb3648af5cd32f5a92f02146763279ac4330e04d"
    sha256 cellar: :any,                 x86_64_linux:  "e42a914eb3c633cab9f1227bb139c3c63f9575258cc0aa856ab99e6fadb6b813"
  end

  depends_on "rustup" => :build
  depends_on "openssl@3"

  def install
    system "rustup", "default", "nightly"
    ENV["OPENSSL_DIR"] = Formula["openssl@3"].opt_prefix
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"akv", "completion", shells: [:bash, :fish, :pwsh, :zsh])
  end

  test do
    assert_match "akv #{version}", shell_output("#{bin}/akv --version")
  end
end
