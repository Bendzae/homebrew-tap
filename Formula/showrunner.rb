class Showrunner < Formula
  desc "A terminal UI for managing multiple coding agent sessions organized by projects and tasks"
  homepage "https://github.com/Bendzae/showrunner"
  version "0.23.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.23.0/showrunner-aarch64-apple-darwin.tar.xz"
      sha256 "b62583c704ac6c594b026ea8cd6aa2ac03dbb55e4c2f9b9df5680384588543ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.23.0/showrunner-x86_64-apple-darwin.tar.xz"
      sha256 "201a7ca89bc43c8c84429f1dfec914e284de1e0819f271be15e3417133345647"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.23.0/showrunner-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "3eb0a630da589a9ab4b841a56e9a1970d0d36027052b8f8cbc61d2250d5fd556"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Bendzae/showrunner/releases/download/v0.23.0/showrunner-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "46dfe632f8bf06572538638390e6fc6341fa6228c1f4d5b4fe34b75cc16beee6"
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
