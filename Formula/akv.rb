class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "4273412524237f556f5a5ebc4b82f99a42637fcfb8f02f871d12c990808e5a90"
  license "MIT"
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any,                 arm64_sequoia: "2af1ef3f0aa274401dbd2630bb5552c1ae6ee65fe1749a1f1b3fa9f2b026a258"
    sha256 cellar: :any,                 arm64_sonoma:  "0f148b8d89d8acd087cc302fa5506968769a850c85183173f448dafc0dbf0a5a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e5946ab219540878554e07eb091b01f2fc79412ed3f18c0527a33dc89ded0487"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "584f104ffdf59c144892e5aca6af0c1058843fc6e7c84514e50188096e7f9457"
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
