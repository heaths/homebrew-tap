class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "0287b6af5ba6420cbe0cb254efb12988e12857d1e976d0b6ea58a99109ef582e"
  license "MIT"
  revision 3
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "350d4014901f4cd99b50e2e7a9f16167c3136b6e75fb154c509c2bdfbf844302"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1c96a29b02903024603faa0fc19505a849f32ccfeee7748fbe5bf9d7ce5ea88c"
    sha256 cellar: :any,                 arm64_linux:   "6fe8395106fcc520749db6cdbfbb07f271ad1998a3f77d45bc1a3478963cd18b"
    sha256 cellar: :any,                 x86_64_linux:  "6892d9e47a36e013d3e635559af065befc0134ed99760930d507df5666ceca22"
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
