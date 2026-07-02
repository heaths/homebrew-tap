class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v1.0.0-beta.1.tar.gz"
  sha256 "d3e76d83cc4ee9b0ec6d12a3949ae47df0f5c7e23ea72fcccfe640ba10a40953"
  license "MIT"
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1f3f8428018f2d95d37c8423ab480ff2b54ab12e6403708943d216a1d51fa90d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3b1890f5f47fc0f9a93d571bccb9ddfbdf1d2761eaa002280cf04a4736dd1c95"
    sha256 cellar: :any,                 arm64_linux:   "5d8b4d5352275cff0ed380819ebf3e9148d8ed31676b201f3e019b33900dadca"
    sha256 cellar: :any,                 x86_64_linux:  "de76fbdacea1a9c9bbcb6f99c3f9d7c56e414276a6e1023c21c25e3f3bbc93da"
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
