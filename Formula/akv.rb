class Akv < Formula
  desc "Azure Key Vault CLI"
  homepage "https://github.com/heaths/akv-cli-rs"
  license "MIT"
  url "https://github.com/heaths/akv-cli-rs/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "9bf9c4801d59fb39535478f0052c6c430b349f9ff33bac9585bb777f813070c2"
  head "https://github.com/heaths/akv-cli-rs.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"akv", "completion")
  end

  test do
    assert_match "akv 0.2.0", shell_output(bin/"akv --version")
  end
end
