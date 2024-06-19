{ inputs, pkgs, ... }: {
  imports = [ inputs.nixos-wsl.nixosModules.wsl ];

  boot.tmp.cleanOnBoot = true;

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    
    gc = {
      automatic = true;
      options = "--delete-older-than 3d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  users = {
    mutableUsers = false;
    users.dawn = {
      isNormalUser = true;
      home = "/home/dawn";
      extraGroups = [ "wheel" ];
      shell = pkgs.nushell;
      hashedPassword = "$6$V7nmrNM8Esdjqh9D$kz2Zr8XuFtw3OXFT6ceTi0VXeY3H4aXunzCum9e2tb1pA.X0cyTRKuKzjn2G3qLHsiG7RO2kBlozPMLwNxkRG0";
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINqXeO6kFPbshxP6Ao6ipF+5x2CkMy9WELPOenjJk5oz dawnofmidnight@duck.com" ];
    };
  };

  system.stateVersion = "23.05";
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  wsl = {
    enable = true;
    defaultUser = "dawn";

    # Enable native Docker support
    # docker-native.enable = true;
    # Enable integration with Docker Desktop (needs to be installed)
    # docker-desktop.enable = true;
  };
}
