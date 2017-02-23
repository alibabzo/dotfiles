{ pkgs, ... }:
with import <nixpkgs> { };
let
  copyFilesInstallPhase = ''
    mkdir $out
    cp -a . $out
  '';

  fisherman = pkgs.stdenv.mkDerivation {
    name = "fisherman";
    src = fetchFromGitHub {
      rev = "99702cf7392b4b4544ed5b3d6a6298f9d3bdb2fc";
      repo = "fisherman";
      owner = "fisherman";
      sha256 = "00a1vp7w2kjargg7ijjm7syrbxn716dp7qyn2635d62fqmbdd41c";
    };
    installPhase = copyFilesInstallPhase;
  };

in
{
  home.packages = with pkgs; [
    acpi
    chromium
    compton
    coreutils
    emacs
    font-awesome-ttf
    ghc
    gimp-with-plugins
    git
    hexchat
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
    roboto
    rofi
    rustc
    shutter
    stack
    stow
    termite
    vlc
    xarchiver
    xclip
    xdotool
    xorg.xev
    xorg.xinput
    xorg.xkbcomp
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
    "bin/colour-scheme".source = ./cfgs/bin/colour-scheme;
    "bin/colour-scheme-boot".source = ./cfgs/bin/colour-scheme-boot;
    "bin/init_keyboard".source = ./cfgs/bin/init_keyboard;
    ".config/xmonad/xmonad.hs".source = ./cfgs/xmonad/xmonad.hs;
    ".config/xmobar/xmobarrc".source = ./cfgs/xmonad/xmobar.hs;
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
