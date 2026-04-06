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
    EDITOR = "zeditor";
    VISUAL = "zeditor";
    BROWSER = "zen";
    TERMINAL = "ghostty";
    PAGER = "less";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    inputs.agenix.packages.${stdenv.hostPlatform.system}.default
    nixd
    nil
    python3
    python3Packages.pip
    python3Packages.virtualenv
    python3Packages.jupyterlab
    nodejs
    go
    javaPackages.compiler.openjdk17
  ];

  home.file = {
    #  ".config/zed/settings.json".source = ../../configs/zed/settings.json;
  };

  imports = [
    ./shell.nix
    ./pass.nix
  ];
}
