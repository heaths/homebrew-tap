class RustNightly < Formula
  desc "Install Rust nightly toolchain"
  homepage "https://www.rust-lang.org"
  version "nightly-2025-11-11"
  license "Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://static.rust-lang.org/dist/#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "8c3426d9a06f20016f68636478b8f3f2077c92abb73f947bd9ecc7a7da084a5d"
    else
      url "https://static.rust-lang.org/dist/#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "f9181ead1af1a2c18124e9cf3a198032b4e9d138783be9433fc4b514712a84b3"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://static.rust-lang.org/dist/#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9c7f14b3dee3fc57125847f7dfc6fe8064c0081bc2d666a32519859672ffbff7"
    else
      url "https://static.rust-lang.org/dist/#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4856cccb8f7d566b881f354743ac39dd705536f2da2623c4df6ec14524d8ada2"
    end
  else
    odie "Unsupported platform for Rust nightly"
  end

  def install
    system "./install.sh", "--prefix=#{prefix}", "--disable-ldconfig"
  end

  test do
    output = shell_output("#{bin}/rustc --version")
    assert_match "nightly", output
  end
end
