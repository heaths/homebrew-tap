class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "b083be4ef3d5a02cda362d66d20db97b1667adfd6e55bf0e4afe97bdfa8c4b78"
  license "MIT"
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "530033bce304b0c39cce718cd25129a038448b87f2dd530051346f995572fd00"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6539930b5915cdc103fed4735ebe53c317730b116aae645eeb5f5e5258461ffd"
    sha256 cellar: :any_skip_relocation, ventura:       "0b16ec811ed7e164cc31f6c0f4da87dc21dedfc5ac0381db041380f9c40ccfd1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "531ff1f6ec0846375911a181a140268dcbf683e22ea73a599406f77671fe111f"
  end

  depends_on "rust" => :build

  on_linux do
    depends_on "openssl@3"
  end

  def install
    ENV["OPENSSL_DIR"] = Formula["openssl@3"].opt_prefix
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"akv", "completion")
  end

  test do
    assert_match "akv 0.3.0", shell_output(bin/"akv --version")
  end
end
