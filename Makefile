all: update test package

update:
	git submodule foreach git pull

test:
	nix-build ./tests.nix --no-out-link --show-trace

package:
	nix-build ./package.nix --no-out-link --show-trace
