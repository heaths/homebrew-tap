class WslRequirement < Requirement
  fatal true

  satisfy(build_env: false) { OS.wsl? }

  def message
    "Requires Windows Subsystem for Linux (WSL)."
  end
end

class Wslawake < Formula
  desc "Keep Windows awake from Linux"
  homepage "https://github.com/heaths/wslawake"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on :linux
  depends_on WslRequirement

  if Hardware::CPU.arm?
    url "https://github.com/heaths/wslawake/releases/download/v0.1.0/linux-arm64.tar.gz"
    sha256 "70572c74f3f430baa42374238d6d912bf42c88ce5bb1f80d85a02ea6e97bb7c2"
  else
    url "https://github.com/heaths/wslawake/releases/download/v0.1.0/linux-x64.tar.gz"
    sha256 "9c21100f39368c88964f3b54d9c92d43dbde1250aa8bfdf583289b859f6abaa7"
  end

  def install
    libexec.install "wslawake", "wslawake.exe"
  end

  service do
    run opt_libexec/"wslawake"
    keep_alive true
  end

  test do
    assert_equal version.to_s, shell_output("#{libexec}/wslawake --version").strip
  end
end
