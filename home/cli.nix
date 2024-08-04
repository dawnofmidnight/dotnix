{ pkgs, ... }: {
  home.packages = with pkgs; [
    fd
    just
    numbat
    patchelf 
    tokei
    wget
  ];

  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.bat = {
    enable = true;
    config.theme = "GitHub";
  };
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fzf.enable = true;

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

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };
}
