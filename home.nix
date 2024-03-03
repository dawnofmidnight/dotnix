{ lib, pkgs, ... }: {
  home = {
    username = "dawn";
    homeDirectory = "/home/dawn";
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;
  home.packages = with pkgs; [ clang_16 fd just nixd numbat patchelf tokei wget ];

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
      theme = "rose_pine_dawn";
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

  programs.zellij = {
    enable = true;
    settings = {
      theme = "rose-pine-dawn";
      themes.rose-pine-dawn = {
        fg = "#575279";
        bg = "#faf4ed";
        black = "#f2e9e1";
        red = "#d7827e";
        green = "#56949f";
        yellow = "#ea9d34";
        blue = "#286983";
        magenta = "#907aa9";
        cyan = "#56949f";
        white = "#797593";
        orange = "#d7827e";
      };
    };
  };

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
