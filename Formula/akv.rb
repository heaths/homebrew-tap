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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "18af090d54a1e7d75431cd7ab11a8d6d4015c9711282f66b1ac1b4af2b4dcd83"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "61752ce008fa6b4e37e168c2d1c338f99323df181f199a124c4c0e1670501466"
    sha256 cellar: :any_skip_relocation, ventura:       "e8cddcced79c0293f667df800bf7663e47dc0db5478b36f7afac4961d56b7913"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bc1df16453880dcb080c848bfca9393ea05f121c68da95cfb72c3d465d08b710"
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
