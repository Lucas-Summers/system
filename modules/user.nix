{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
  users.users."lucas" = {
    home = "/Users/lucas";
    description = "Lucas Summers";
    shell = pkgs.fish;
  };
  system.primaryUser = "lucas";
  networking.hostName = "m5";
  networking.computerName = "m5";
  system.defaults.smb.NetBIOSName = "m5";

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.lucas = import ./home.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
