{ lib, modulesPath, ... }: {
  imports = lib.optional (builtins.pathExists ./do-userdata.nix) ./do-userdata.nix ++ [
    (modulesPath + "/virtualisation/digital-ocean-config.nix")
  ];

  networking.hostName = "sunset";

  boot.tmp.cleanOnBoot = true;

  system.stateVersion = "24.11";
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
}
