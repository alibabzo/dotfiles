{
  allowUnfree = true;
  chromium = {
    enablePepperFlash = true;
  };
  packageOverrides = pkgs: rec {
    neovim = pkgs.neovim.override {
      vimAlias = false;
      withPython = true;
      withPython3 = true;
      withRuby = true;
      configure = import ./pkgs/nvim-config { inherit pkgs; };
    };

    home-manager = import ./pkgs/home-manager { modulesPath = "$HOME/.nixpkgs/pkgs/home-manager/modules"; inherit pkgs; };
  };
}
