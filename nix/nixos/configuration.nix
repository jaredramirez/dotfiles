# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  common = import ./../common.nix { inherit pkgs; };
in
{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = "1048576";
  };

  # Load network driver
  boot.extraModulePackages = with config.boot.kernelPackages; [ r8125 ];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.hostName = "home";
  networking.networkmanager.enable = true;
  networking.extraHosts = ''
    127.0.0.1 example.com
    127.0.0.1 sub.example.com
  '';

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the Plasma 5 Desktop Environment.
  # Uncomment to use desktop
  # services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable opengl
  hardware.opengl.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users.jared = {
    shell = pkgs.fish;
    isNormalUser = true;
    home = "/home/jared/";
    hashedPassword = "$6$x5MiN5Yih9x$jFgKT3tvBCKyZx/07WuTJeFlsb0o3woSDTuJ5Zw6EEtJgA5PMdpt5bz2s44OMhkWTffjOIStoGKcPwivzI9ys/";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };
  nix.trustedUsers = [ "root" "jared" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = common.systemPackages ++ [
    pkgs.libssh2
  ];

  # Setup binary cache
  nix.binaryCachePublicKeys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" ];
  nix.binaryCaches = [ "https://hydra.iohk.io" ];

  # List programs to use:

  # Programs
  programs.zsh = common.programs.zsh;
  programs.bash = common.programs.bash;
  programs.fish = common.programs.fish;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Use flakes
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

