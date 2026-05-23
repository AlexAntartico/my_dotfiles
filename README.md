# my_dotfiles

Personal dotfiles, organized by life stage. The active setup is **CachyOS** with a symlink-based install. Older configs from Fedora and Linux Mint days are preserved under `legacy/` for reference.

## Layout

```
my_dotfiles/
├── current/           Active CachyOS setup — symlinked into $HOME
│   ├── .zshrc
│   ├── .tmux.conf
│   └── .config/
│       ├── alacritty/
│       │   ├── alacritty.toml
│       │   └── themes/
│       │       └── nord.toml
│       ├── starship.toml
│       └── zsh/cachyos-config.zsh   (local override of /usr/share/.../cachyos-config.zsh)
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

## Changelog

### 2026-05-22
- **Alacritty theme refactor:** extracted inline Nord colors into `current/.config/alacritty/themes/nord.toml`; main config now imports the theme and owns only behavior (fonts, window, keybindings). Dropped `night-contrast.toml`.
- **`.zshrc`:** fixed hardcoded `/home/eddieg/` path for LM Studio bin to use `$HOME`.
- **`alacritty.toml`:** fixed `font.bold_italic` family from `monospace` to `JetBrainsMono Nerd Font`.
- **Repo hygiene:** added top-level `.gitignore` (covers `*.bak`, OS files); removed `migrate.sh` (one-time migration already completed); fixed duplicate `.claude/` entry in `current/.gitignore`.

## Notes

- The `current/` files assume CachyOS packages are installed (`starship`, `zoxide`, `lsd`, `btop`, `fzf`, `tmux`, `zsh-syntax-highlighting`, `zsh-autosuggestions`, `pkgfile`, `oh-my-zsh-git`). Most of these are in the CachyOS default repos.
- For Vim plugins, install vim-plug from <https://github.com/junegunn/vim-plug>, then run `:PlugInstall` inside Vim.
- For tmux plugins, install TPM from <https://github.com/tmux-plugins/tpm>, then press `prefix + I` inside a tmux session to fetch the plugins (`tmux-sensible`, `tmux-resurrect`, `tmux-continuum`).
- The `.gitignore` in `current/` excludes shell history, `.ssh/`, `.gnupg/`, and `.cache/` — review before committing if you add new files.
