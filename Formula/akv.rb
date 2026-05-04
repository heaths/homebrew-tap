class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.10.2.tar.gz"
  sha256 "fa6d82c4ec64f2e6f607a88a3e3133262156473f8d4ae65e7d5805188b2039ce"
  license "MIT"
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "dfca39e1271a90343191812c036666ba7085da56298e67e078a2d8b7ff677fb3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "95caf0f07ab3c37c55eba6ca2ec19cf803989d8590b3773fbe5b79126ef694e6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "accfaf49a56d3fcfaa75fbb312c3c8f95df77f1becc4efe7568010219c47200d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "642d13921d380dc6717c84e106883ab8c1e298e4a0b518c6e66276c4b23a091d"
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
