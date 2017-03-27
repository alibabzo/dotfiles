{ pkgs }:

let
  customPlugins = import ./plugins.nix { inherit (pkgs) vimUtils fetchFromGitHub; };
  initvim = builtins.readFile ./init.vim;
in
{
  customRC = initvim;

  vam.knownPlugins = pkgs.vimPlugins // customPlugins;
  vam.pluginDictionaries = [
    "ale"
    "deoplete-nvim"
    "neco-ghc"
    "neosnippet-vim"
    "neosnippet-snippets"
    "nord-vim"
    "Supertab"
    "The_NERD_tree"
    "vim-airline"
    "vim-gitgutter"
    "vim-nix"
    "vim-one"
  ];
}
