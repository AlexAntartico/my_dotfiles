# my_dotfiles

Personal dotfiles, organized by life stage. The active setup is **CachyOS** with a symlink-based install. Older configs from Fedora and Linux Mint days are preserved under `legacy/` for reference.

## Layout

```
my_dotfiles/
├── current/           Active CachyOS setup — symlinked into $HOME
│   ├── .zshrc
│   ├── .tmux.conf
│   ├── .config/
│   │   ├── alacritty/
│   │   ├── starship.toml
│   │   └── zsh/cachyos-config.zsh   (local override of /usr/share/.../cachyos-config.zsh)
│   ├── install.zsh    Run this to set up symlinks
│   └── README.md
│
├── shared/            Cross-distro configs (symlinked alongside current/)
│   └── .vimrc
│
├── scripts/           Standalone utility scripts
│   ├── update_debian.sh    apt/snap/flatpak updater with logging
│   ├── ssformater.sh       Cleans Linux Mint screenshot filenames
│   └── dotfiles_to_repo.sh Legacy copy-based backup (kept for reference)
│
└── legacy/            Older distro-specific configs, not actively used
    ├── fedora/
    │   └── aliases.sh      Bash aliases, dnf5, custom PS1, fastfetch
    └── mint/
        ├── kitty.conf
        └── color.ini       Tokyo Night palette for kitty
```

## Installation

```zsh
git clone https://github.com/AlexAntartico/my_dotfiles.git ~/Projects/my_dotfiles
cd ~/Projects/my_dotfiles
chmod +x install.zsh
./install.zsh
```

The install script walks `current/` and `shared/`, creating symlinks under `$HOME` that mirror the directory structure. If a file already exists at the destination, it's backed up to `<file>.bak` before the symlink is created. Re-running the script is safe — files already correctly linked are skipped.

## Why two zsh config files?

CachyOS ships a system-wide oh-my-zsh + plugin config at `/usr/share/cachyos-zsh-config/cachyos-config.zsh`. Editing it directly would be wiped on the next `pacman -Syu`. Instead, this repo keeps a local copy at `current/.config/zsh/cachyos-config.zsh` with Powerlevel10k disabled (since this setup uses Starship). The top-level `.zshrc` sources the local copy, not the system one.

This is two files by design, not by accident.

## Stack

- **Shell:** zsh + oh-my-zsh + Starship prompt
- **Terminal:** Alacritty (with tmux auto-attach)
- **Multiplexer:** tmux with TPM (resurrect + continuum)
- **Editor:** Vim with vim-plug
- **Extras:** zoxide, fzf, lsd, btop, lazygit

## Scripts

`scripts/update_debian.sh` — APT + Snap + Flatpak updater with timestamped logging to `/var/log`. Must be run as root. Useful on Debian/Mint machines.

`scripts/ssformater.sh` — Renames screenshot files: strips Linux Mint's leading/trailing single quotes and replaces spaces with underscores. Run from the directory containing the screenshots.

`scripts/dotfiles_to_repo.sh` — Older copy-based backup script. Superseded by the symlink approach in `install.zsh` but kept around in case it's useful on a machine where symlinks aren't viable.

## Notes

- The `current/` files assume CachyOS packages are installed (`starship`, `zoxide`, `lsd`, `btop`, `fzf`, `tmux`, `zsh-syntax-highlighting`, `zsh-autosuggestions`, `pkgfile`, `oh-my-zsh-git`). Most of these are in the CachyOS default repos.
- For Vim plugins, install vim-plug from <https://github.com/junegunn/vim-plug>, then run `:PlugInstall` inside Vim.
- The `.gitignore` in `current/` excludes shell history, `.ssh/`, `.gnupg/`, and `.cache/` — review before committing if you add new files.
