{
  imports = [
    ./cli.nix
    ./dev.nix
  ];

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
