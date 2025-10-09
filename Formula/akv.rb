class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "1a142d78a9ceb12d909d5ffe67b0e9823b39237154a110d34267b0dc12025dad"
  license "MIT"
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any,                 arm64_sequoia: "a2c2a455681492110cbbf3115a8764a803c30128d77df26f8c47f8a832e04fe9"
    sha256 cellar: :any,                 arm64_sonoma:  "9090701fa1da6f809c36fdd6e9821e435c3c2e569c6a0079684522e44c1636bd"
    sha256 cellar: :any,                 ventura:       "3e1bddf491831bddf10a6f457f8bd393a564e39c4bb1923538e0e7f175b09fd4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b207aac121237cce09d531ddac3e30a1f3ba7e99c4eaab7c68ae5779a573a27e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2f28a41d0fb12afe571497180f157f3b37678812e2513310f36a805f9d50d981"
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
