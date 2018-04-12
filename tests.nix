{ system ? builtins.currentSystem }:
with (import ./nixpkgs { });

let
  testing = import ./nixpkgs/nixos/lib/testing.nix { inherit system; };

in {

  testHest = testing.makeTest {

    name = "first-test";

    machine = { config, lib, pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        go-ethereum
      ];
    };

    testScript = ''
      $machine->succeed("ls /dev");
    '';
  };

}
