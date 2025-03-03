class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "9bf9c4801d59fb39535478f0052c6c430b349f9ff33bac9585bb777f813070c2"
  license "MIT"
  revision 2
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "faee668caf71ac3bf7b51e30810da58ce541f4a6e70cf90c141304bc9f9fa3c4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f42aa60b3ba167119287bdfe89a1e17176b832442f8edf8272d361a2b45b8b83"
    sha256 cellar: :any_skip_relocation, ventura:       "5f31036014e214d28aca7f383207948f75f8699bd5332b08a3cf2d7741a41e8e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bc5e67c4b20d5c0fc2a31f80385508f3dd3ac0b6427b459b86dff4c016ce6bcf"
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
    assert_match "akv 0.2.0", shell_output(bin/"akv --version")
  end
end
