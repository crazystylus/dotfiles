let
  rust = import (builtins.fetchTarball
    "https://github.com/oxalica/rust-overlay/archive/ad311f5bb5c5ef475985f1e0f264e831470a8510.tar.gz");
  pkgs = import <nixpkgs> { overlays = [ rust ]; };
  pkgs-latest = import (builtins.fetchTarball
    "https://github.com/NixOS/nixpkgs/archive/3ef1d2a9602c18f8742e1fb63d5ae9867092e3d6.tar.gz")
    { };
in pkgs.mkShell {
  buildInputs = [
    # Rust
    pkgs.rust-bin.stable.latest.default

		# Shell
		pkgs-latest.bash
		pkgs-latest.zsh

		# Editor
		pkgs-latest.neovim

		# Dependencies
		pkgs.fzf
		pkgs.zoxide
		pkgs.exa
		pkgs-latest.nodejs-16_x
	];
}
