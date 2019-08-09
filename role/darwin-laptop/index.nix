{ config, lib, pkgs, ... }:
{
  imports = [
    # Files to source for fish config
    ../../program/shell/fish/sources.nix
    ../../program/file-manager/ranger/index.nix

    # Darwin only
    ./script/index.nix
  ];

  programs.alacritty = {
    enable = true;
    settings = lib.attrsets.recursiveUpdate (import ../../program/terminal/alacritty/default-settings.nix) {
      shell.program = "/usr/local/bin/fish";
    };
  };

  # Fish Shell
  programs.fish = lib.attrsets.recursiveUpdate(import ../../program/shell/fish/default.nix) {
    shellInit = ''
      set PATH (cd $HOME/.config/scripts/ | fd --absolute-path | tr '\n' ':' | sed 's/.$//') $PATH
    '';
  };

  # Environment
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  home.file.".hammerspoon".source = ../../de/darwin-only/hammerspoon;
}
