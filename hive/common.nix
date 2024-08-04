{ inputs, pkgs, system, ... }: {
  imports = [ inputs.lix.nixosModules.default ];

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  environment.systemPackages = [ inputs.colmena.defaultPackage.${system} ];

  services = {
    openssh.enable = true;
    tailscale.enable = true;
  };

  users = {
    mutableUsers = false;
    users.dawn = {
      isNormalUser = true;
      home = "/home/dawn";
      extraGroups = [ "docker" "wheel" ];
      shell = pkgs.nushell;
      hashedPassword = "$6$V7nmrNM8Esdjqh9D$kz2Zr8XuFtw3OXFT6ceTi0VXeY3H4aXunzCum9e2tb1pA.X0cyTRKuKzjn2G3qLHsiG7RO2kBlozPMLwNxkRG0";
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINqXeO6kFPbshxP6Ao6ipF+5x2CkMy9WELPOenjJk5oz dawnofmidnight@duck.com" ];
    };
  };
}
