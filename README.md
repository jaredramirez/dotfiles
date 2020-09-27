# Dotfiles

This my [nix](https://nixos.org/nix/https://nixos.org/nix/) and [nix-darwin](https://github.com/LnL7/nix-darwin) configuration. This setup assumes you're on MacOS Catalina.

## Setup

### 1
Install nix with:
```
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
```

### 2
Install nix-darwin with:
```
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer
```
### 3
Clone this repo with (it's important that where you clone this repo now is where you want to keep it):
```
mkdir ~/dev/github/jaredramirez/dotfiles
cd ~/dev/github/jaredramirez/dotfiles
git clone https://github.com/jaredramirez/dotfiles.git
cd dotfiles
```

### 4
Boostrap this repo with your system:
```
./boostrap.sh
```

### 5
Run nix-darwin with the bootstrapped files
```
darwin-rebuild switch
```

### 6
Make fish the default shell:
```
echo `which fish` | sudo tee -a /etc/shells
chsh -s `which fish` 
```

### 7
Install Neovim plugins with:
```
update_nvim
```

### 8
Install [karabiner-elements](https://karabiner-elements.pqrs.org/)
Setup Caps Lock to be Esc if pressed one, or Ctrl if held by following [this guide](https://karabiner-elements.pqrs.org/docs/manual/configuration/configure-complex-modifications/).

### 9
Install [Dashlane](https://www.dashlane.com/)


### 8
Open up firefox and login to your profile!
