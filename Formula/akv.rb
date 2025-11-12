class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.7.2.tar.gz"
  sha256 "49f81a9d0cd4f7d02fb19c8454c6167fd33e3b1f867fc384828e85083c2ca5f2"
  license "MIT"
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any,                 arm64_sequoia: "fb0b83800dacce48a17ee712be6e5c38b792602f62717ed690b1a8f34ca4245b"
    sha256 cellar: :any,                 arm64_sonoma:  "7b92c2fdd055f8f71c80f7043dbe3b34eb89c4bd8acf8f22e526d40a86f07b44"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "662eb2b3f72fd60200b962a7cbb59dd828979e94596ba1746b2b600962fc6696"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4cf1d8a352cb3a3d5b8ff3024d6ba8d2b89b16b90241d0e0ee16d377bdd7d4b0"
  end

  depends_on "rustup" => :build
  depends_on "openssl@3"

  def install
    system "rustup", "default", "nightly"
    ENV["OPENSSL_DIR"] = Formula["openssl@3"].opt_prefix
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"akv", "completion")
  end

  test do
    assert_match "akv #{version}", shell_output("#{bin}/akv --version")
  end
end
