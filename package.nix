with (import ./nixpkgs { });

let
  src = (builtins.filterSource
    (path: type: type != "directory" || baseNameOf path != ".git")
    ./.);

in pkgs.runCommand "package-nixpkgs" {} ''
  mkdir ''${out}
  tar -cpzf ''${out}/nixpkgs.tar.gz -C ${src} .
''
