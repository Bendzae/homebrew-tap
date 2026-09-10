class Showrunner < Formula
  desc "A terminal UI for managing multiple coding agent sessions organized by projects and tasks"
  homepage "https://github.com/Bendzae/showrunner"
  version "0.25.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.25.0/showrunner-aarch64-apple-darwin.tar.xz"
      sha256 "0cbafcf4ae3b5fcd867356b4cfb5ec6420678731338e57485a7f99ffc31ead13"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.25.0/showrunner-x86_64-apple-darwin.tar.xz"
      sha256 "fe516862e8b27a32a2eb722446252d703717748d08eda10237b73e4c49a08894"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.25.0/showrunner-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "56fb96c110d0d5d73eb68788e2517d9157e3b669938903ce71b27b4eae7e7b5f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.25.0/showrunner-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5c93ba9c271070e5fd4024d9de235dad485f5340d621f383743fcdf7d94f6dc6"
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
