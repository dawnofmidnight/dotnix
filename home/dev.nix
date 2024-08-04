{ lib, pkgs, ... }: {
  home.packages = with pkgs; [ nixd ];

  home.file.".cargo/config.toml".text = ''
    [build]
    target-dir = ".cache/cargo_target"

    [target.x86_64-unknown-linux-gnu]
    linker = "${lib.getExe pkgs.llvmPackages_16.clang}"
    rustflags = ["-Clink-arg=-fuse-ld=${lib.getExe pkgs.mold}", "-Ctarget-cpu=native"]

    [unstable]
    gc = true
  '';
  
  programs.git = {
    enable = true;
    userName = "dawnofmidnight";
    userEmail = "dawnofmidnight@duck.com";
    ignores = [ "/.direnv/" ".envrc" ];
    extraConfig = {
      core.editor = "${lib.getExe pkgs.helix}";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      "url \"git@github.com:\"".pushInsteadOf = "https://github.com/";
      "url \"git@gist.github.com:\"".pushInsteadOf = "https://gist.github.com/";
    };
    delta = {
      enable = true;
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "dawnofmidnight";
        email = "dawnofmidnight@duck.com";
      };
      ui = {
        diff = [ "${pkgs.delta}" "$left" "$right" ];
        editor = "hx";
      };  
    };
  };
}
