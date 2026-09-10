class Showrunner < Formula
  desc "A terminal UI for managing multiple coding agent sessions organized by projects and tasks"
  homepage "https://github.com/Bendzae/showrunner"
  version "0.24.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.24.0/showrunner-aarch64-apple-darwin.tar.xz"
      sha256 "843ef2f7ab7d04d42a2d53c118f0b6e88ca5f21b6983f5b6f72bb0bf0b70ce38"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.24.0/showrunner-x86_64-apple-darwin.tar.xz"
      sha256 "15982f672523aa2e248cd59eb1e489ae4031809e232cd42653c866d4acb4dd9c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.24.0/showrunner-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c76b7591fd0fb6a98ee5ff79ebbaa9ba9d084e07eca3a40993f548807363f143"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.24.0/showrunner-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d53c7cdebfa55e0dd37dad0ae51ebdfb7baf5d057936bdd9c17bb389eeb84ed4"
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
