# alibabzo's dotfiles

Dotfiles are personal Linux configuration files.
These are mine, and they're how I've customised my system.
Feel free to copy/fork/modify/share, that's what this is all about.

# Managing

I manage my dotfiles with [`home-manager`](https://github.com/rycee/home-manager).

# Program list

* **Operating System**: [NixOS](https://nixos.org)
* **Text editor**: [neovim](http://neovim.io)
  * See `overlays/neovim/default.nix` for plugins
* **Colour scheme**: [nord](https://github.com/arcticicestudio/nord-vim)
* **Shell**: [fish](https://fishshell.com)
  * with [fisherman](https://github.com/fisherman/fisherman)
* **Terminal emulator**: [termite](https://github.com/thestinger/termite)
* **Desktop environment**: [Xfce](http://www.xfce.org)
* **Window manager**: [xmonad](http://xmonad.org)
  * **Bar**: [xmobar](http://projects.haskell.org/xmobar)
* **Browser**: [chromium](https://www.chromium.org/Home)
* **Music player**: [ncmpcpp](http://rybczak.net/ncmpcpp/)
  * **Backend**: [mopidy](https://www.mopidy.com/)
* **IRC client**: [weechat](https://weechat.org/)

# Directory structure

```
. <- you are here
├── cfgs
│   ├── bin - scripts
│   ├── fish - shell configuration
│   ├── termite - terminal configuration
│   ├── xkb - custom keyboard layout
│   └── xmonad - xmonad & xmobar configuration
├── config.nix - nixpkgs configuration
├── home.nix - config for home-manager (most stuff is in here)
├── overlays
│   ├── home-manager - link to home-manager package
│   └── neovim - neovim configuration
└── README.md - what you're reading
```
# Screenshot
[![homescreen](https://github.com/alibabzo/dotfiles/raw/master/screenshot.png)](screenshot)
