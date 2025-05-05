{ config, lib, pkgs, inputs, ... }:

let
  # Fetch the nixpkgs-mozilla overlay
  moz_overlay = inputs.nixpkgs-mozilla.packages.${pkgs.system}.default.overrideAttrs (old: {
    meta = old.meta or {};  # Optional, can add maintainers here if needed
  });

  # Fetch Firefox Nightly using the overlay
  firefox_nightly = inputs.nixpkgs-mozilla.packages.${pkgs.system}.latest.firefox-nightly-bin;
in
{
  # Adding Firefox Nightly to system-wide environment packages
  environment.systemPackages = with pkgs; [
    firefox_nightly  # Add Firefox Nightly to system packages
  ];

  # If using home-manager, you can add Firefox Nightly to user-specific environment packages
  home-manager.users.${config.username} = home-manager.lib.homeManagerConfiguration {
    pkgs = pkgs;  # Use the appropriate package set
    extraSpecialArgs = {
      pkgsUnstable = inputs.nixpkgs-unstable.packages.${pkgs.system};
    };
    modules = [ ./home/common.nix ];

    # Add Firefox Nightly to user-specific environment packages
    environment.systemPackages = with pkgs; [
      firefox_nightly  # Add Firefox Nightly to user environment packages
      # Additional user-specific packages go here
    ];
  };
}

