build-macos:
	nix build ./\#darwinConfigurations."Jareds-MacBook-Pro".system

switch-macos:
	./result/sw/bin/darwin-rebuild switch --flake .

macos:
	make build-macos && make switch-macos
