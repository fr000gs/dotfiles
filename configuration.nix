# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./vimconf.nix
    ./cardware-honf.nix
    ./programs.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 10;
      efi.canTouchEfiVariables = true;
    };
    #kernelParams = ["resume_offset=4562837"];
    kernel.sysctl = { "vm.swappiness" = 60;};
    #resumeDevice = "/dev/nixvol/rootvol";
    supportedFilesystems = [ "ntfs" ];
    tmp.useTmpfs = true;
  };

  powerManagement.enable = true;

  environment.variables = {
    GTK_USE_PORTAL = 1;
  };

  #swapDevices = [ {
  #  device = "/var/lib/swapfile";
  #  size = 16400;
  #} ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  #networking.useDHCP = true;

  networking = {
    nameservers = [
      "2606:4700:4700::1111"  # Cloudflare IPv6
      "2606:4700:4700::1001"
      "2001:4860:4860::8888"  # Google IPv6
      "1.1.1.1"               # Cloudflare IPv4
      "1.0.0.1"
    ];
  };
  # Enable systemd-resolved
  services.resolved = {
    enable = true;

    fallbackDns = [
      "2001:4860:4860::8844"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };
  # And symlink /etc/resolv.conf to its stub
  #networking.resolvconf.enable = false;

  time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "C.UTF-8";
  #i18n.extraLocaleSettings = {
  #  en_
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
};

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  #hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  
  #services.udev.extraHwdb = ''
  #  evdev:name:*:*
  #   KEYBOARD_KEY_70=volumeup    # Scroll Lock (usually code 46)
  #   KEYBOARD_KEY_119=volumedown  # Pause/Break (usually code 45)
  #'';


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  #services.pulseaudio.enable = false;

  services = {
    desktopManager.plasma6.enable = true;
    fstrim.enable = true;    
    #blueman.enable = true;
    flatpak.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 80;
  };
  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.fr000gs = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "libvirtd" ]; # Enable ‘sudo’ for the user.
  };

  nix.optimise.automatic = true;
  #nix.optimise.dates = [ "03:45" ]; # Optional; allows customizing optimisation schedule

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 30d";
  };

  systemd.services.nixos-rebuild-boot = {
    description = "Update bootloader after nix-gc";
    after = [ "nix-gc.service" ];
    requires = [ "nix-gc.service" ];
    wantedBy = [ "nix-gc.service" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = [ "/run/current-system/sw/bin/nixos-rebuild" "boot" ];
    };
  };


  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.variables = rec {
    ANDROID_NDK_HOME = "/home/fr000gs/Android/Sdk/ndk/29.0.13599879/";
    GVIM_ENABLE_WAYLAND = 1;
    EDITOR = "vim";
  };

  virtualisation.libvirtd = {
    #enable = true;
    qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  security.polkit.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # <--
  nixpkgs.config.allowUnfree = true;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  #_______________________________________________________________________________________________________________
  #*********END*****************

  system.stateVersion = "25.11"; # Did you read the comment?

}

