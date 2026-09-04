class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "0287b6af5ba6420cbe0cb254efb12988e12857d1e976d0b6ea58a99109ef582e"
  license "MIT"
  revision 1
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a68d5023ad234dc02318a45df3b968177a32b02d0d10f208af0b6bcc2abf5861"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0d6e306d86aa0cc01f09adaa0c05d19ce86d8eb36c3ba612fbb5f3440c9f23f9"
    sha256 cellar: :any,                 arm64_linux:   "a1458f4674cf11b11779cab204108a7ec020adf2e0ef624a8bd9b27b972827a3"
    sha256 cellar: :any,                 x86_64_linux:  "26323344e81768677e509770020b96b2e80690309973dfd7c1b10065cac8683f"
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
