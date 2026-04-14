{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      #Xcode = 497799835;
    };

    # `brew tap ...`
    taps = [
      "manaflow-ai/cmux"
      "human37/open-wispr"
    ];

    # `brew install ...`
    brews = [
      "pass"
      "git"
      "pandoc"
      "ripgrep"
      "docker"
      "fzf"
      "pi-coding-agent"
      "fd"
      "googleworkspace-cli"
      "human37/open-wispr/open-wispr"
    ];

    # `brew install --cask ...`
    casks = [
      "ghostty"
      "spotify"
      "discord"
      "slack"
      "zed"
      "zen"
      "obsidian"
      "codex"
      "ungoogled-chromium"
      "android-commandlinetools"
      "android-platform-tools"
      "gcloud-cli"
      "cmux"
    ];
  };
}
