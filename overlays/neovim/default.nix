self: super:
let
  customPlugins = import ./plugins.nix { inherit (self) vimUtils fetchFromGitHub; };
  initvim = builtins.readFile ./init.vim;
in
{
  neovim = super.neovim.override {
    vimAlias = false;
    withPython = true;
    withPython3 = true;
    configure = {
      customRC = initvim;
      vam.knownPlugins = self.vimPlugins // customPlugins;
      vam.pluginDictionaries = [
        "airline"
        "deoplete-nvim"
        "gitgutter"
        "neco-ghc"
        "neomake"
        "neosnippet"
        "neosnippet-snippets"
        "nerdtree"
        "nord-vim"
        "polyglot"
        "vim-one"
      ];
    };
  };
}
