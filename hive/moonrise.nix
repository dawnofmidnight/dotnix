{ inputs, pkgs, ... }: {
  imports = [ inputs.nixos-wsl.nixosModules.wsl ];

  networking.hostName = "moonrise";

  boot.tmp.cleanOnBoot = true;

  system.stateVersion = "24.11";
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # allow vscode and whatnot to work
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  virtualisation.docker.enable = true;

  wsl = {
    enable = true;
    defaultUser = "dawn";
  };
}
