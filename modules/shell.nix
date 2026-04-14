{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  programs.fish = {
    enable = true;

    shellAliases = {
      ll = "ls -l";
      la = "ls -la";
    };

    functions.nix-switch = {
      body = ''
        if test (count $argv) -ne 1
          echo "usage: nix-rebuild <host>"
          return 2
        end

        set host $argv[1]
        sudo darwin-rebuild switch --flake /Users/lucas/System#$host
      '';
    };

    interactiveShellInit = ''
      set -g fish_greeting
      bind \cz 'fg 2>/dev/null; commandline -f repaint'
      /opt/homebrew/bin/brew shellenv | source
    '';
  };
}
