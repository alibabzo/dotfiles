# alibabzo's dotfiles

Dotfiles are personal Linux configuration files.
These are mine, and they're how I've customised my system.
Feel free to copy/fork/modify/share, that's what this is all about.

# Managing

I manage my dotfiles with GNU Stow. Example:
Run `stow i3` to install i3 config
Run `stow -D i3` to remove i3 config

# Program list

* **Operating System**: [Arch](https://www.archlinux.org)
* **Text editor**: [neovim](http://neovim.io)
  * with [dein.vim](https://github.com/Shougo/dein.vim) as plugin manager
  * See `nvim/.config/nvim/init.vim` for plugins
* **Colour scheme**: [oceanic-next](https://github.com/voronianski/oceanic-next-color-scheme)
* **Shell**: [zsh](https://www.zsh.org)
  * with [zim](https://github.com/Eriner/zim)
* **Terminal emulator**: [rxvt-unicode](http://software.schmorp.de/pkg/rxvt-unicode.html)
* **Notification daemon**: [dunst](https://github.com/knopwob/dunst)
* **Window manager**: [i3-gaps](https://github.com/Airblader/i3)
  * **Bar**: [i3bar-gaps with i3blocks](https://github.com/vivien/i3blocks)
  * **Launcher**: [rofi](https://github.com/DaveDavenport/rofi)
* **Browser**: [qutebrowser](https://github.com/The-Compiler/qutebrowser)
* **Music player**: [ncmpcpp](http://rybczak.net/ncmpcpp/)
  * **Backend**: [mopidy](https://www.mopidy.com/)
* **IRC client**: [weechat](https://weechat.org/)

# Directory structure

```
. <- you are here
├── bin - scripts
├── compton - window compositor configuration
├── dunst - notification configuration
├── firefox - firefox css
├── gtk - configuration for gtk
├── i3 - i3 configuration
├── i3blocks - i3blocks configuration
├── nvim - configuration file for nvim
├── qutebrowser - configuration for qutebrowser
├── README.md - what you're reading
├── redshift - configuration for your eyes
├── rofi - launcher configuration
├── screenshot.png - screenshot
├── tmux - terminal multiplexer configuration
├── x - x configuration, including urxvt and colourscheme
└── zsh - shell configuration

```
# Screenshot
[![homescreen](https://github.com/alibabzo/dotfiles/raw/master/screenshot.png)](screenshot)
