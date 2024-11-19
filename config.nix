{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-packages";
      paths = [
        neovim
        go
        air
        fd
        ripgrep
        fzf
        tmux
      ];
    };
  };
}
