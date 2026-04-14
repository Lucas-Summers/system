{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  programs.helix = {
    enable = true;
    ignores = [ ];
    extraPackages = with pkgs; [
      marksman
      ty
      nil
      nixd
    ];
    languages = {

    };
    settings = {
      theme = "base16_transparent";
      editor = {
        line-number = "relative";
      };
      keys = {
        normal = {
          C-g = [
            ":write-all"
            ":new"
            ":insert-output lazygit"
            ":buffer-close!"
            ":redraw"
            ":reload-all"
          ];
        };
      };
    };
  };
}
