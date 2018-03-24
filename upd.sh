#!/usr/bin/env nix-shell
#! nix-shell -i bash -p curl jq gnutar xz nix git github-release --pure
set -o pipefail
set -e
set -u
set -x

cur_rev=$(git rev-parse HEAD)

# Get current state of of channel
rev=$(curl 'https://api.github.com/repos/nixos/nixpkgs-channels/commits?sha=nixos-unstable-small' | jq -r 'first.sha')
url="https://codeload.github.com/NixOS/nixpkgs-channels/tar.gz/${rev}"
nixpkgs=$(nix-prefetch-url --unpack --print-path "${url}" | tail -n 1)

# Run tests
nix-build -I "nixpkgs=${nixpkgs}" ./default.nix

# Create artifact
tar -cp -C "${nixpkgs}" . | xz -9e -c > nixpkgs.tar.xz

# Create github release
# github-release release --tag "${rev}"
# github-release upload --tag "${rev}" --name "nixpkgs.tar.xz" --file ./nixpkgs.tar.xz
