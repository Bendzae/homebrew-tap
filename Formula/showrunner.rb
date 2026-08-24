class Showrunner < Formula
  desc "A terminal UI for managing multiple coding agent sessions organized by projects and tasks"
  homepage "https://github.com/Bendzae/showrunner"
  version "0.21.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.21.0/showrunner-aarch64-apple-darwin.tar.xz"
      sha256 "5a02a7deb4e9cef9422839aaf90dd7c5c64ff15f845c70f40cc87d51fedc23d2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.21.0/showrunner-x86_64-apple-darwin.tar.xz"
      sha256 "f9c524b938b620cbf931e3861278f0bb2feec99012610dcc80d654ba29b4267d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.21.0/showrunner-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6912479303a887c572c1fdb3845c21fe1b86945c69fdd8725c8a71edae71e395"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.21.0/showrunner-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "75ca0096a5aab07f269d238904f2984c2f1281212ea27b9e329dd65b52079c80"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "showrunner"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "showrunner"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "showrunner"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "showrunner"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
