class Showrunner < Formula
  desc "A terminal UI for managing multiple coding agent sessions organized by projects and tasks"
  homepage "https://github.com/Bendzae/showrunner"
  version "0.20.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.20.1/showrunner-aarch64-apple-darwin.tar.xz"
      sha256 "f73d642f4998649bcaf75764ba535e338de7acab23bad0a7581057ffcb9e2690"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.20.1/showrunner-x86_64-apple-darwin.tar.xz"
      sha256 "098dd9fe400686cf57cc43206abf34d6a85758b82751597e36e272c0b0a1c6cd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.20.1/showrunner-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ace8ca027afab2dbe8dc730f4d712b95c2f809d16c2696df1fbb1532e391dd74"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.20.1/showrunner-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "782d596418bde075c88f0ff7e934cd1c23d1204fd14f1c45bbb9bce16ad1e802"
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
