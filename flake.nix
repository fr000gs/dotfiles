#{
#  #outputs = inputs @ {
#  #  nixpkgs,
#  #  ...
#  #}:
#  #let
#  #  system = "x86_64-linux"; # change to whatever your system should be
#  #in
#  #{
#  #  nixosConfigurations."${host}" = nixpkgs.lib.nixosSystem {
#  #    specialArgs = {
#  #      inherit system;
#  #      inherit inputs;
#  #    };
#  #    modules = [
#  #      {nixpkgs.overlays = [inputs.hyprpanel.overlay];}
#  #    ];
#  #  };
#  #};
#  inputs = {
#    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
#    hyprland.url = "github:hyprwm/Hyprland";
#    hyprland-plugins = {
#      url = "github:hyprwm/hyprland-plugins";
#      inputs.hyprland.follows = "hyprland";
#    };
#    outputs = inputs@{ self, nixpkgs, ... }: {
#    # NOTE: 'nixos' is the default hostname
#    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
#      modules = [
#        ./configuration.nix
#        {nixpkgs.overlays = [inputs.hyprpanel.overlay];}
#      ];
#    };
#  };
#}
#};

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {
      inherit inputs;
    };
      modules = [
        ./configuration.nix
        { nixpkgs.overlays = [inputs.hyprpanel.overlay]; }
      ];
    };
  };
}
