{  }:

let
  nixpkgs = import ./nixpkgs { };
  dapphub = import ./dapphub/overlay/overlay.nix {
    self=nixpkgs;
    super=nixpkgs;
  };

in (nixpkgs // { inherit dapphub; })
