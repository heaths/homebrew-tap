class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "9bf9c4801d59fb39535478f0052c6c430b349f9ff33bac9585bb777f813070c2"
  license "MIT"
  revision 1
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/heaths/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "de1fea0bea3e049183ae65fb9eb7a8dfe437a82bea29e60f56fc68ce5e7b0612"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "661d82559b783eb1802cfa334901478979839022eabb1d5f6abe43ab3d093951"
    sha256 cellar: :any_skip_relocation, ventura:       "ebee39ac2f1b86bef072094468b21902c741b64e34b97ac53e746e26d95b6226"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"akv", "completion")
  end

  test do
    assert_match "akv 0.2.0", shell_output(bin/"akv --version")
  end
end
