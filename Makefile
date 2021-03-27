build-pesonal-macos:
	nix build ./\#darwinConfigurations."Jareds-MacBook-Pro".system
	
build-work-macos:
	nix build ./\#darwinConfigurations."Jareds-Work-MacBook-Pro".system

switch-macos:
	./result/sw/bin/darwin-rebuild switch --flake .

personal-macos:
	make build-personal-macos && make switch-macos
	
work-macos:
	make build-work-macos && make switch-macos
