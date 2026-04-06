{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  nix = {
    enable = true;
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [ "lucas" ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };
  environment.systemPackages = with pkgs; [
    vim
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
  ];
}
