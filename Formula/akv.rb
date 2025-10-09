class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "1a142d78a9ceb12d909d5ffe67b0e9823b39237154a110d34267b0dc12025dad"
  license "MIT"
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any,                 arm64_sequoia: "fadf1a45c1d9bad2d46969f55b5e3149e5a35aad11a69f3f924c435632e345b8"
    sha256 cellar: :any,                 arm64_sonoma:  "17cf104b24d3056b2a2da46ad73a80abf34e73679a91034864f5e7bddca749cc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4b2f83a76e08db4863683645cf3917fbf8568830f061cee77525eaff6b362359"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "df911fb9d1924699d896c322eed56e200a5cefa219a357e813e662d3ec9a312a"
  end

  depends_on "rust" => :build
  depends_on "openssl@3"

  def install
    ENV["OPENSSL_DIR"] = Formula["openssl@3"].opt_prefix
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"akv", "completion")
  end

  test do
    assert_match "akv #{version}", shell_output("#{bin}/akv --version")
  end
end
