class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.6.2-pre.tar.gz"
  sha256 "c088bb3dc1e04884e13ad899cbf036020a694bbe76da21b59fa5eb4bccf8961b"
  license "MIT"
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any,                 arm64_sequoia: "a326dddc39e0b9a5ec45d44f9c1856f1e5c1d3e7301fc33e0611af877b3b10fb"
    sha256 cellar: :any,                 arm64_sonoma:  "e0eb13e2b6c1b2ca0a567aaa487184e1140c761e7b1d3e2b1675beb96a507fa9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9e46f1a7db28105c88aeeb79cdc0dae52b477a68268a0f8685f769decac9e7bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4c0b4ca990820b3e4f7bc52809203b2d9c1ad1e25204cec4f114a44c73a348dc"
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
