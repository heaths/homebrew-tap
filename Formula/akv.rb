class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "aa6820147ad7f3ff5a4ae82a975ddc6b1a810464e593a8c4157d92f3ca48f5f8"
  license "MIT"
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any,                 arm64_sequoia: "c781b649f261ceb77569309fcf271472ade5733f621dd238a7f4e13304d39c24"
    sha256 cellar: :any,                 arm64_sonoma:  "a6236079a8a8a6a6cfadc81cc31925b11f407c82e0dcedb5f3788845ad6d7cd2"
    sha256 cellar: :any,                 ventura:       "e950294d30ce11413623a562af7c383cb85f9b2111763442f54b99e380582c51"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "354f1a71e22835592600094a2a37843ab8af4e6304038ad3ee18692dce1d980f"
  end

  depends_on "rust" => :build
  depends_on "openssl@3"

  def install
    ENV["OPENSSL_DIR"] = Formula["openssl@3"].opt_prefix
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"akv", "completion")
  end

  test do
    assert_match "akv 0.4.0", shell_output(bin/"akv --version")
  end
end
