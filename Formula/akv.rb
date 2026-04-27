class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "788a20427d2ac498362606cb79b8f5dbae0d751123f3b794948fdbb2f6c1d8d4"
  license "MIT"
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any,                 arm64_sequoia: "c94c20c2b74cde31dd37dcca8b21fee5b5c718eb10b0f1509998c505b412c12e"
    sha256 cellar: :any,                 arm64_sonoma:  "7a8c783911533e4b739fc9c5f778109b93ef77cb5a422747bed9569a03615101"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1ea70613ec975329bc439c489b7bf6cac068fa3b180801e7c09f611f3486cb5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "df39bac00f0a252ea88a22ce0ef662c78814164d94b1aaa6ec16451230feb6af"
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
