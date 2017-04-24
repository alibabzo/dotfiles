{ pkgs, lib, ...}:
let
  /*
  From
  { file = "regular"; file2 = "directory"; }
  to
  { "location/file".source = path/file; }
  */
  getFiles = location: path:
    lib.mapAttrs' (name: value: lib.nameValuePair (location + ("/" + name))
    ({ source = (path + ("/" + name)); })) (builtins.readDir path);

  getScriptFiles = location: path:
    lib.mapAttrs' (name: value: lib.nameValuePair (location + ("/" + name))
    ({ source = (path + ("/" + name)); mode = "0755"; })) (builtins.readDir path);

  fisherman = pkgs.stdenv.mkDerivation {
    name = "fisherman";
    src = pkgs.fetchFromGitHub {
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
    chromium
    coreutils
    font-awesome-ttf
    gimp-with-plugins
    hexchat
    haskellPackages.stack-run
    htop
    libnotify
    lxappearance
    neofetch
    neovim
    nitrogen
    nox
    pavucontrol
    psmisc
    ripgrep
    roboto
    rofi
    scrot
    stack
    termite
    vlc
    xarchiver
    xclip
    zip
  ];

  programs.git = {
    enable = true;
    userName = "Alistair Bill";
    userEmail = "alistair.bill@gmail.com";
  };

  gtk = {
    enable = true;
    fontName = "Roboto 10";
    iconThemeName = "Paper";
    themeName = "Arc-Dark";

    gtk3.extraCss = ''
      VteTerminal, vte-terminal {
        padding: 10px;
      }
    '';
  };

  home.file =
  {
    ".config/xmobar/xmobarrc".source = ./cfgs/xmobar/xmobarrc;

    ".config/xmonad/xmonad.hs".source = ./cfgs/xmonad/xmonad.hs;
    ".config/xmonad/lib/XMobar.hs".source = ./cfgs/xmonad/lib/XMobar.hs;


    ".config/fish/functions/fisher.fish".source = "${fisherman}/fisher.fish";
    ".config/fish/fishfile".source = ./cfgs/fish/fishfile;

    ".config/xkb/symbols/poker".source = ./cfgs/xkb/poker;
  }
  // getFiles ".config/fish/functions" ./cfgs/fish/functions
  // getFiles ".config/fish/conf.d" ./cfgs/fish/conf.d
  // getFiles ".config/termite" ./cfgs/termite
  // getScriptFiles ".config/xmobar/scripts" ./cfgs/xmobar/scripts
  // getScriptFiles "bin" ./cfgs/bin;
}

