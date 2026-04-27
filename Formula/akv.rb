class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.9.2.tar.gz"
  sha256 "e1fe91d44953f390b5234bf24f7375ddef3d7b3fd82945392fbcf292bdcc0bc4"
  license "MIT"
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any,                 arm64_sequoia: "41f7dc226cee1285f263f19bb4c302681cd2dce584fdb175a6f47b12e7146544"
    sha256 cellar: :any,                 arm64_sonoma:  "652f5b75076a0864478c123233258808f391a200a8be8d02466c6db50a2ccdd9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e61a772cad9aece01942928b1a8c469b4748dc3582209d22ea019bf947fb93c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4787c23891bc60869258c009c2ea5c71a56ae23c0da84835ca2fd1949bd72858"
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
