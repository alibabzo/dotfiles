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
      rev = "99702cf7392b4b4544ed5b3d6a6298f9d3bdb2fc";
      repo = "fisherman";
      owner = "fisherman";
      sha256 = "00a1vp7w2kjargg7ijjm7syrbxn716dp7qyn2635d62fqmbdd41c";
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
    cargo
    chromium
    compton
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
    htop
    imagemagick
    jq
    jsoncpp
    lxappearance
    mono
    msgpack-tools
    ncmpcpp
    neofetch
    neovim
    netcat-openbsd
    nitrogen
    nox
    openssl
    pavucontrol
    perl
    psmisc
    python
    python3
    ripgrep
    roboto
    rofi
    rustc
    shellcheck
    shutter
    stack
    stow
    termite
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
  ];

  programs.git = {
    enable = true;
    userName = "Alistair Bill";
    userEmail = "alistair.bill@gmail.com";
  };

  services.redshift = {
    enable = true;
    latitude = "51.5";
    longitude = "-2.6";
    temperature.day = 5700;
    temperature.night = 3500;
  };

  home.file = {
    "bin/colour-scheme" = script ./cfgs/bin/colour-scheme;
    "bin/colour-scheme-boot" = script ./cfgs/bin/colour-scheme-boot;
    "bin/init_keyboard" = script ./cfgs/bin/init_keyboard;
    "bin/shutdown_menu" = script ./cfgs/bin/shutdown_menu;
    ".config/xmobar/scripts/network.sh" = script ./cfgs/xmonad/scripts/network.sh;
    ".config/xmobar/scripts/load.sh" = script ./cfgs/xmonad/scripts/load.sh;
    ".config/xmobar/scripts/volume.sh" = script ./cfgs/xmonad/scripts/volume.sh;
    ".config/xmobar/scripts/battery.sh" = script ./cfgs/xmonad/scripts/battery.sh;
    ".config/xmonad/xmonad.hs".source = ./cfgs/xmonad/xmonad.hs;
    ".config/xmonad/lib/XMobar.hs".source = ./cfgs/xmonad/lib/XMobar.hs;
    ".config/xmobar/xmobarrc".source = ./cfgs/xmonad/xmobarrc;
    ".config/compton.conf".source = ./cfgs/compton/compton.conf;
    ".config/rofi/launcher".source = ./cfgs/rofi/launcher;
    ".config/termite/config-dark".source = ./cfgs/termite/config-dark;
    ".config/termite/config-light".source = ./cfgs/termite/config-light;
    ".xkb/symbols/poker".source = ./cfgs/xkb/poker;
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
