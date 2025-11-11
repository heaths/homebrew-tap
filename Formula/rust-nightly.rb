class RustNightly < Formula
  desc "Install Rust nightly toolchain"
  homepage "https://www.rust-lang.org"
  version "2025-11-11"
  license "Apache-2.0"

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://static.rust-lang.org/dist/#{version}/rust-nightly-aarch64-apple-darwin.tar.gz"
      sha256 "faca660ec8122e515cbd3e3032ef4c2f152e0ef4cf85ff3f786d70d1dd6cff2e"
    else
      url "https://static.rust-lang.org/dist/#{version}/rust-nightly-x86_64-apple-darwin.tar.gz"
      sha256 "e5baf7f775760ff3f6056f17cc4d3e84592634e86de0fb3cf333d2790c6d068f"
    end
  elsif OS.linux?
    if Hardware::CPU.arm?
      url "https://static.rust-lang.org/dist/#{version}/rust-nightly-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f6193fea528778ac6bbe0e503aa235d58ef907535a7d9b0f27a642c08576dde8"
    else
      url "https://static.rust-lang.org/dist/#{version}/rust-nightly-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6e18cd9290b004c372e8497e1d118ecccf670d6c0bd527f67942e8605582cfdd"
    end
  else
    odie "Unsupported platform for Rust nightly"
  end

  def install
    system "./install.sh", "--prefix=#{prefix}"
  end

  test do
    output = shell_output("#{bin}/rustc --version")
    assert_match "nightly", output
  end
end
