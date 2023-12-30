{ lib, pkgs, ... }: {
  home = {
    username = "dawn";
    homeDirectory = "/home/dawn";
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;
  home.packages = with pkgs; [ clang_16 rustup tokei typst typst-lsp wget ];

  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;
  };
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "dawnofmidnight";
    userEmail = "dawnofmidnight@duck.com";
    ignores = [ "/.direnv/" ".envrc" ];
    extraConfig = {
      core.editor = "${lib.getExe pkgs.helix}";
      init.defaultBranch = "main";
    };
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "github_light";
      editor = {
        line-number = "relative";
        true-color = true;
        auto-save = true;
        rulers = [80];
        bufferline = "always";
        color-modes = true;
        lsp = {
          display-messages = false;
          display-inlay-hints = true;
        };
        cursor-shape = {
          normal = "bar";
          insert = "bar";
          select = "bar";
        };
      };
    };
  };

  programs.nushell = {
    enable = true;
    configFile.source = ./nushell/config.nu;
    envFile.source = ./nushell/env.nu;
  };

  programs.ripgrep.enable = true;

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };
  

  home.file.".cargo/config.toml".text = ''
    [build]
    target-dir = ".cache/cargo_target"

    [target.x86_64-unknown-linux-gnu]
    linker = "${lib.getExe pkgs.llvmPackages_16.clang}"
    rustflags = ["-Clink-arg=-fuse-ld=${lib.getExe pkgs.mold}", "-Ctarget-cpu=native"]

    [unstable]
    gc = true
  '';
}
