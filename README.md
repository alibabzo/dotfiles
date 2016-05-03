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
  * See `nvim/.config/nvim/init.vim` for plugins
* **Color scheme**: [oceanic-next](https://github.com/voronianski/oceanic-next-color-scheme)
* **Shell**: [zsh](https://www.zsh.org)
  * with [tmux](https://tmux.github.io)
  * and [zplug](https://github.com/b4b4r07/zplug)
* **Terminal emulator**: [st](http://st.suckless.org)
* **Notification daemon**: [dunst](https://github.com/knopwob/dunst)
* **Window manager**: [i3](http://i3wm.org)
  * **Bar**: [i3bar with i3blocks](https://github.com/vivien/i3blocks)
  * **Launcher**: [rofi](https://github.com/DaveDavenport/rofi)
* **Browser**: Firefox
  * **Theme**: Twily's Powerline (modified)
* **Music player**: [cmus](https://wiki.archlinux.org/index.php/Cmus)
* **IRC client**: [irssi](https://irssi.org/)

# Directory structure

```
. <- you are here
├── atom - configuration for gui text editor
├── bin - scripts
├── compton - window compositor configuration
├── dunst - notification configuration
├── firefox - firefox css
├── gtk - configuration for gtk
├── i3 - i3 rice
├── i3blocks - i3 bar rice
├── irssi - irc client configuration
├── nvim - configuration file for nvim
├── README.md - what you're reading
├── redshift - configuration for your eyes
├── rofi - launcher configuration
├── screenshot.png - screenshot
├── termite - terminal emulator configuration
├── tmux - terminal multiplexer configuration
├── urxvt - another terminal emulator configuration
├── vimperator - vim for firefox configuration
├── yaourt - short yaourt configuration
└── zsh - shell configuration

```
# Screenshot
[![homescreen](https://github.com/alibabzo/dotfiles/raw/master/screenshot.png)](screenshot)

---

Thanks to @alexbooker, many of the ideas here are his
