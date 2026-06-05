class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.11.0.tar.gz"
  sha256 "aa90f6d96d01b44f92d7d4c2a1a504196c9f46dabd58d037c65f5493a40a735c"
  license "MIT"
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cd87ac2284405ad5156a965133f841a0c8fe052fa4bfc42261fe2a540591f56d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ad37740a8a8e88aa927bc19d6494be2bd285d4a9b63d2c5e4764bb800f6b07d3"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ab24fd90056d1634d989034180101cfb0abb133ea49c586271cba9203dbf73b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7b159c17eb75d974cd399d554d65ecea3f072e78f4a88208fdf83e26db42faca"
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
