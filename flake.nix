{
  description = "A simple flake for some ROS action!";

  nixConfig = {
    bash-prompt = "[ros-playground]";
    #extra-substituters = [ https://ros.cachix.org ];
    #trusted-public-keys = [ ros.cachix.org-1:dSyZxI8geDCJrwgvCOHDoAfOm5sV1wCPjBkKL+38Rvo= ];
  };

  inputs = {
    flake-utils.url = github:numtide/flake-utils;
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.05;
    nix-ros.url = github:lopsided98/nix-ros-overlay;
  };

  outputs = { self, nixpkgs, flake-utils, nix-ros }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
      ros = nix-ros.legacyPackages.${system};
      # NOTE Some pkgs like colcon are missing from the ros.legacyPackages.
      # Therefore instantiate a nixpkgs set with the ros overlay to provide
      # them for now.
      # NOTE Use ros.legacyPackages per default, as packages from the overlay
      # result into more builds and downloads... somehow.
      missingROSPkgs = import nixpkgs {
          inherit system;
          overlays = [ nix-ros.overlay ];
      };
    in {
      devShells.default = pkgs.callPackage ./shell.nix {
        ros = ros.foxy;
        inherit (missingROSPkgs) colcon;
      };
    });
}
