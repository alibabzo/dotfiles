{ pkgs, ... }:
with import <nixpkgs> { };
let
  script = source: {
    inherit source;
    mode = "0755";
  };

  fisherman = pkgs.stdenv.mkDerivation {
    name = "fisherman";
    src = fetchFromGitHub {
      rev = "91f447ec4087635ea988e6864288cb73a0aba504";
      repo = "fisherman";
      owner = "fisherman";
      sha256 = "1qjxkz2rvd5d6zfh2xw21niy7xh4hhbdh89szdiwydyywrsq025h";
    };
    installPhase = ''
      mkdir $out
      cp -a . $out
    '';
  };

in
{
  home.packages = with pkgs; [
    acpi
    bc
    chromium
    coreutils
    emacs
    feh
    font-awesome-ttf
    ghc
    gimp-with-plugins
    git
    hexchat
    haskellPackages.hindent
    haskellPackages.hlint
    haskellPackages.stack-run
    htop
    imagemagick
    jq
    libnotify
    lxappearance
    mono
    msgpack-tools
    ncmpcpp
    neofetch
    neovim
    netcat-openbsd
    nitrogen
    nox
    pavucontrol
    psmisc
    ripgrep
    roboto
    rofi
    scrot
    shellcheck
    stack
    termite
    unzip
    vim-vint
    vlc
    weechat
    wirelesstools
    xarchiver
    xclip
    xdotool
    xorg.xev
    xorg.xinput
    xorg.xkbcomp
    xorg.xmessage
    xorg.xset
    zip
  ];

  programs.git = {
    enable = true;
    userName = "Alistair Bill";
    userEmail = "alistair.bill@gmail.com";
  };

  home.file = {
    # scripts
    "bin/colour-scheme" = script ./cfgs/bin/colour-scheme;
    "bin/init_keyboard" = script ./cfgs/bin/init_keyboard;
    "bin/shutdown_menu" = script ./cfgs/bin/shutdown_menu;

    # xmobar
    ".config/xmobar/scripts/network.sh" = script ./cfgs/xmobar/scripts/network.sh;
    ".config/xmobar/scripts/load.sh" = script ./cfgs/xmobar/scripts/load.sh;
    ".config/xmobar/scripts/volume.sh" = script ./cfgs/xmobar/scripts/volume.sh;
    ".config/xmobar/scripts/battery.sh" = script ./cfgs/xmobar/scripts/battery.sh;
    ".config/xmobar/xmobarrc".source = ./cfgs/xmobar/xmobarrc;

    # xmonad
    ".config/xmonad/xmonad.hs".source = ./cfgs/xmonad/xmonad.hs;
    ".config/xmonad/lib/XMobar.hs".source = ./cfgs/xmonad/lib/XMobar.hs;

    # misc
    ".config/compton.conf".source = ./cfgs/compton/compton.conf;
    ".config/rofi/launcher".source = ./cfgs/rofi/launcher;
    ".config/termite/config-dark".source = ./cfgs/termite/config-dark;
    ".config/termite/config-light".source = ./cfgs/termite/config-light;
    ".xkb/symbols/poker".source = ./cfgs/xkb/poker;

    # fish
    ".config/fish/conf.d/aliases.fish".source = ./cfgs/fish/conf.d/aliases.fish;
    ".config/fish/conf.d/prompt.fish".source = ./cfgs/fish/conf.d/prompt.fish;
    ".config/fish/conf.d/vimode.fish".source = ./cfgs/fish/conf.d/vimode.fish;
    ".config/fish/functions/cd.fish".source = ./cfgs/fish/functions/cd.fish;
    ".config/fish/functions/extract.fish".source = ./cfgs/fish/functions/extract.fish;
    ".config/fish/functions/fisher.fish".source = "${fisherman}/fisher.fish";
    ".config/fish/fishfile".source = ./cfgs/fish/fishfile;
  };

  gtk = {
    enable = true;
    fontName = "Roboto 10";
    iconThemeName = "Paper";
    themeName = "Arc-Dark";

    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';

    gtk3.extraConfig = {
      gtk-cursor-theme-size = 16;
      gtk-cursor-theme-name = "Paper";
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };

    gtk3.extraCss = ''
      VteTerminal, vte-terminal {
        padding: 10px;
      }
    '';
  };
}
