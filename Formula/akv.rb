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
    sha256 cellar: :any,                 arm64_sequoia: "c9fe8a8e8dac06e9dac4a0bcc504c27653d5c2882247a894cdb90a0a1394dd8d"
    sha256 cellar: :any,                 arm64_sonoma:  "128dace019377d8340351b3087590a8b4b4fcf90cd8e5c9cd93481693e871bd5"
    sha256 cellar: :any,                 ventura:       "7a96b8e0520d9452cff5fb24a4d233612ec3c8cdead4cd36773d3d23f6fb03fb"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a617056771a763f8131c5a56b3be89d2c437b3629220b92ac08c3090cb326857"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a617056771a763f8131c5a56b3be89d2c437b3629220b92ac08c3090cb326857"
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
