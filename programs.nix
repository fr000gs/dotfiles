{ config, lib, pkgs, inputs, ... }:
with lib; let
  hyprPluginPkgs = inputs.hyprland-plugins.packages.${pkgs.system};
  hypr-plugin-dir = pkgs.symlinkJoin {
    name = "hyrpland-plugins";
    paths = with hyprPluginPkgs; [
      hyprexpo
      hyprbars
      #...plugins
    ];
  };
in
{
  environment.sessionVariables = { HYPR_PLUGIN_DIR = hypr-plugin-dir; };
  environment.systemPackages = with pkgs; [
    wget
    git
    killall
    htop
    kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice  ***********KDE START*********
    kdePackages.kcalc # Calculator
    kdePackages.kcharselect # Tool to select and copy special characters from all installed fonts
    kdePackages.kcolorchooser # A small utility to select a color
    #kdePackages.ktouch    
    libsForQt5.ktouch
    kdePackages.ksystemlog # KDE SystemLog Application
    kdePackages.sddm-kcm # Configuration module for SDDM
    kdiff3 # Compares and merges 2 or 3 files or directories
    kdePackages.isoimagewriter # Optional: Program to write hybrid ISO files onto USB disks
    kdePackages.partitionmanager # Optional Manage the disk devices, partitions and file systems on your computer
    hardinfo2 # System information and benchmarks for Linux systems
    haruna # Open source video player built with Qt/QML and libmpv
    wayland-utils # Wayland utilities
    wl-clipboard # Command-line copy/paste utilities for Wayland                                ************KDE END**********
    flatpak
    steam-run-free
    rustup
    smartmontools
    starship
    pay-respects
    mc
    kdePackages.dolphin
    python314
    gnome-network-displays
    #anydesk
  ];

users.users.fr000gs.packages = with pkgs; [
      tree
      kitty
      nwg-dock-hyprland
      nwg-clipman
      nwg-panel
      nwg-drawer
      nwg-menu
      nwg-look
      nwg-displays
      #hyprland
      rofi
      #dunst
      nerd-fonts.jetbrains-mono
      #nerdfetch
      xdg-desktop-portal-hyprland
      wireplumber
      hyprpolkitagent
      #ashell
      motrix
      android-studio
      chromium
      libreoffice-qt6-fresh
      appeditor
      krita
      scrcpy
      vlc
      ffmpeg_6-full
      papirus-icon-theme
      hyprpanel
      wl-clipboard
      xwayland
      kdePackages.kdenlive
      vscode
    ];
      programs = {
    virt-manager.enable = true;
    firefox.enable = true;
    chromium.enable = true;
    chromium.extensions = [
      "eimadpbcbfnmbkopoojfekhnkhdbieeh"
      "hdannnflhlmdablckfkjpleikpphncik"
      "jngkenaoceimiimeokpdbmejeonaaami"
      "ghagedffjalchgcgdgfindabkpnmalel"
    ];
    hyprland.enable = true;
    starship.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      histSize = 10000;
      setOptions = [
        "AUTO_CD"
      ];
      shellInit = ''
        '';
      #prompInit = ''
      #  source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      #'';
      ohMyZsh = {
        enable = true;
        plugins = [
          "starship"
          "cp"
          "alias-finder"
          "git"
          "history"
          "dirhistory"
        ];
      };
    };
  };
}
