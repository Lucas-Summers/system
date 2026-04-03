{ config, pkgs, lib, inputs, ... }:

let
  passwordStoreDir = "${config.home.homeDirectory}/.password-store";
  gnupgDir = "${config.home.homeDirectory}/.gnupg";
in
{
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableFishIntegration = true;
  };

  age = {
    identityPaths = [
      "${config.home.homeDirectory}/.ssh/id_ed25519"
    ];

    secrets = {
      gpg_priv = {
        file = ../secrets/gpg_priv.asc.age;
      };

      gpg_pub = {
        file = ../secrets/gpg_pub.asc.age;
      };
    };
  };

  home.activation.importGpgForPass =
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      set -eu

      export GNUPGHOME="${gnupgDir}"

      PUB="${config.age.secrets.gpg_pub.path}"
      PRIV="${config.age.secrets.gpg_priv.path}"

      mkdir -p "$GNUPGHOME"
      chmod 700 "$GNUPGHOME"

      # Only import if no secret keys exist yet
      if ! ${pkgs.gnupg}/bin/gpg --homedir "$GNUPGHOME" --list-secret-keys | grep -q '^sec'; then
        if [ -f "$PUB" ]; then
          ${pkgs.gnupg}/bin/gpg --homedir "$GNUPGHOME" --batch --import "$PUB"
        fi

        if [ -f "$PRIV" ]; then
          ${pkgs.gnupg}/bin/gpg --homedir "$GNUPGHOME" --batch --import "$PRIV"
        fi

        if [ -f "$PUB" ]; then
          FPR="$(
            ${pkgs.gnupg}/bin/gpg \
              --homedir "$GNUPGHOME" \
              --with-colons \
              --show-keys "$PUB" \
              | ${pkgs.gawk}/bin/awk -F: '/^fpr:/ { print $10; exit }'
          )"

          if [ -n "$FPR" ]; then
            echo "$FPR:6:" | ${pkgs.gnupg}/bin/gpg \
              --homedir "$GNUPGHOME" \
              --batch \
              --import-ownertrust
          fi
        fi
      fi
    '';


  home.activation.passStore =
    lib.hm.dag.entryBefore [ "linkGeneration" ] ''
      if [ ! -f "${passwordStoreDir}/.git/config" ]; then
        GIT_SSH_COMMAND=/usr/bin/ssh \
          ${pkgs.git}/bin/git clone git@github.com:Lucas-Summers/passwords.git "${passwordStoreDir}"
      fi
    '';

  home.file.".password-store/.git/hooks/post-commit".source =
    ../scripts/pass-post-commit;
}