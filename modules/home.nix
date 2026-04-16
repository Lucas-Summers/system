{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  home.username = "lucas";
  home.homeDirectory = "/Users/lucas";
  home.stateVersion = "25.11";
  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "zed";
    BROWSER = "zen";
    TERMINAL = "ghostty";
    PAGER = "less";
    HOMEBREW_NO_ENV_HINTS = 1;
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    inputs.agenix.packages.${stdenv.hostPlatform.system}.default
    python3
    python3Packages.pip
    python3Packages.virtualenv
    python3Packages.jupyterlab
    nodejs
    go
  ];

  home.file = {
    #  ".config/zed/settings.json".source = ../../configs/zed/settings.json;
    ".config/ghostty/config.ghostty".text = ''
      font-family = "Iosevka Nerd Font Mono"
      font-size = 14
    '';
  };

  imports = [
    ./shell.nix
    ./pass.nix
    ./edit.nix
  ];
}
