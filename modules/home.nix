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
    BROWSER = "firefox";
    TERMINAL = "cmux";
    PAGER = "less";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    inputs.agenix.packages.${stdenv.hostPlatform.system}.default
    nixd
    nil
  ];

  home.file = {
    #  ".config/zed/settings.json".source = ../../configs/zed/settings.json;
  };

  imports = [
    ./shell.nix
    ./pass.nix
  ];
}
