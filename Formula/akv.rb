class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "ce7eff7db02e8f9b1a2c6eb90f4bc6bd9782da4f790c219f45ddf7dcd3ff3ce9"
  license "MIT"
  revision 1
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any,                 arm64_sequoia: "5cd22bb4f4b4288ba0dd4a2560364b21642ef665baaa6e2401be6086da91ee8c"
    sha256 cellar: :any,                 arm64_sonoma:  "2655b31644c930110635f0b6c6e424531e38e8c32e035f232fa25d8ed806f9e9"
    sha256 cellar: :any,                 ventura:       "a91fb1abcf1ee1e89ea24c0977dca05e7a381ecdd262ca0fc46aad0fe3d8993d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ee95957834a9ea39152d3114ec32809e3d17f143264b7092e77dced248743444"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "26225b3b7504afdcbb9379ad1b2bbe2dbb9bd237ec47a8e40557975eb3597a90"
  end

  depends_on "rust" => :build
  depends_on "openssl@3"

  def install
    ENV["OPENSSL_DIR"] = Formula["openssl@3"].opt_prefix
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"akv", "completion")
  end

  test do
    assert_match "akv #{version}", shell_output(bin/"akv --version")
  end
end
