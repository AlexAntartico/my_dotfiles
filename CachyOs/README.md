# CachyOS Dotfiles

A "lift and shift" dotfiles configuration tailored for CachyOS, using a symlink-based approach to keep your home directory in sync with this repository.

## 🚀 Features
- **Symlink Managed**: Changes made in your home directory are reflected here automatically.
- **Automated Install**: Simple Zsh script to set up links and backup existing configs.
- **Modern Stack**: Includes configurations for Alacritty, Starship, Tmux, and Zsh.

## 📂 Structure
The repository mirrors the structure of your `$HOME` directory:
- `.zshrc` -> `~/.zshrc`
- `.tmux.conf` -> `~/.tmux.conf`
- `.config/alacritty/` -> `~/.config/alacritty/`
- `.config/starship.toml` -> `~/.config/starship.toml`
- `.config/zsh/` -> `~/.config/zsh/`

## 🛠 Installation

1. **Clone the repository:**
   ```zsh
   git clone https://github.com/yourusername/your-repo-name.git ~/Projects/my_dotfiles
   cd ~/Projects/my_dotfiles/CachyOs
   ```

2. **Run the install script:**
   ```zsh
   chmod +x install.zsh
   ./install.zsh
   ```

### What the script does:
1. Iterates through all files in this repository.
2. Creates the necessary directories in your `$HOME` folder.
3. If a file already exists at the target location, it creates a `.bak` backup.
4. Creates a symbolic link from your `$HOME` to the file in this repository.

## ⚠️ Safety & PII
This repository has been audited for Personal Identifiable Information (PII) and secrets. It contains only functional configurations. Always review files before adding them to the repository if you plan to keep this public.
