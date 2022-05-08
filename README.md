![screenshot-desktop](https://i.imgur.com/sgvnYrl.png)

# massivebird's dotfiles

Fedora Linux btw

# programs

+ [`sway`](https://github.com/swaywm/sway) window manager
+ [`waybar`](https://github.com/Alexays/Waybar) status bar
+ [`kitty`](https://sw.kovidgoyal.net/kitty/) terminal
+ [`zsh`](https://www.zsh.org/) shell
+ [`nvim`](https://github.com/neovim/neovim) text editor
+ [`ranger`](https://github.com/ranger/ranger) file browser

## installation

This repo is intended to be cloned into/as the system's `~/.config` directory.

Here is an inefficient example of such:

```bash
git clone https://github.com/massivebird/dotfiles
mv dotfiles/* ~/.config
rm -rf dotfiles
```

I'll make a better way later I promise

## my favorite ./scripts

### arcstat.sh

Displays statistics about my local game archive.

![arcstat-preview](https://i.imgur.com/6q6SrFS.png)

### shell-splash.sh

A welcoming message to start the day.

Executed by shell on start-up alongside `git-updater.sh` (see below).

Here is a typical start-up screen:

![shell-splash-preview](https://i.imgur.com/tcLmsIB.png)

### git-updater.sh

Updates local git repositories (very cool!)

This runs every time I source my shell rc, which includes booting up my machine(s) 😎

![git-updater-preview](https://i.imgur.com/ulG5AnG.gif)

> Utilizes `./scripts/lib/loading-spinner.sh` to create a loading animation

### wiicheck.sh

Validates file system conventions for USB Loader GX, a Wii Homebrew app.

![wiicheck-preview](https://i.imgur.com/DaCQKue.png)

## misc

[wallpaper](https://unsplash.com/photos/VWEFQ7q9GFw)
