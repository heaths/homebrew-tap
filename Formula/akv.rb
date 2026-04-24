class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.9.1.tar.gz"
  sha256 "8c21852e5e88a473611da8c9bedbad9d74af852aaf386d19884fdc8b88d0b070"
  license "MIT"
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    sha256 cellar: :any,                 arm64_sequoia: "9db528545be449603559aa85944c83d3ac1b59b29ce55e59b87673b279691fda"
    sha256 cellar: :any,                 arm64_sonoma:  "1cafbb3809e8b38798280766243a1b7eafdc45268156ad2e79b6a5566e158d4e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "72125765a5617caf159444d36fc73b7dfc09bceffe435d96b08736202187acf3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "65d25397274d8a2bad03a642d0a95f269ba84d8f85dfd0aecd6a9e236a9e8a25"
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
