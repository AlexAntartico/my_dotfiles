# my_dotfiles

My personal dotfiles for configuring my development environment. This repo includes configuration for Vim, Bash aliases, and scripts to manage and back up my dotfiles. The purpose of this file is to have a repo  with my personal preferences, you may use these as the base for your own purposes. 

## Contents

### 1. `.vimrc` – Vim Configuration & Plugins

- **Custom Settings:**  
  - Sets leader key to `,` for custom shortcuts.
  - Line numbers, smart indentation, tab spacing set to 4 spaces.
  - Enables line wrapping, syntax highlighting, mouse support, and cursor line highlighting.
  - Sets UTF-8 encoding and a custom command-line prompt style.

- **Search and Editing:**  
  - Highlights search results, ignores case (unless uppercase in search), and shows matching brackets.
  - Smart auto-indenting, auto-completion features, and plugins for enhanced editing.

- **Plugins (managed by vim-plug):**  
  - `vim-plug` for plugin management.
  - `davidhalter/jedi-vim` for Python development (Jedi-based autocompletion).
  - Additional plugins may be defined (see the full `.vimrc` for more).

- **Vim-Markdown Plugin Settings:**  
  - Disables concealing of markdown syntax and code blocks for better readability.
  - 
- **Local indentation settings**
- Applied to my most used languages.

[View .vimrc](https://github.com/AlexAntartico/my_dotfiles/blob/main/.vimrc)

---

### 2. `aliases.sh` – Bash Aliases and Prompt Customization

- **Purpose:**  
  Provides shorthand aliases for common commands to increase efficiency.

- **Highlights:**  
  - File and directory listing enhancements (`ll`, `la`, `ld`).
  - Shorthand for moving up directories (`d1`, `d2`, etc.).
  - System info and upgrade (`df`, `upme`, `top`).
  - Python .gitignore downloader (`py_gitignore`).
  - Enhanced `less` and `cat` (`bat`) for color and line numbers.
  - Colored grep output.
  - Reloads `.bashrc` with `reloadb`.
  - Customizes the shell prompt (PS1) for better visibility (time, user, host, path).
  - Invokes `fastfetch` for a summary at shell startup.

[View aliases.sh](https://github.com/AlexAntartico/my_dotfiles/blob/main/aliases.sh)

---

### 3. `dotfiles_to_repo.sh` – Dotfiles Backup Script

- **Purpose:**  
  Script to copy selected dotfiles from your home directory to this repository for backup and synchronization.

- **Usage:**
  1. Edit the "USER CONFIGURATION" section to define which files to back up and the repository path.
  2. Make the script executable:  
     `chmod +x dotfiles_to_repo.sh`
  3. Run the script:  
     `./dotfiles_to_repo.sh`

- **Features:**  
  - Checks if repo path exists and creates it if needed.
  - Copies only newer versions of files (using `cp -uv`).
  - Skips missing files and provides informative output.
  - Easy to extend for additional dotfiles.


### 4. `update_debian.sh` (NEW)

- Bash script to update and clean APT and Snap packages on Debian-based systems.
- Logs actions to /var/log with a timestamped filename.
- Must be run as root (with sudo).
- Provides on-screen and log feedback about the update process.


[View dotfiles_to_repo.sh](https://github.com/AlexAntartico/my_dotfiles/blob/main/dotfiles_to_repo.sh)

---

## How to Use

1. Clone this repo to your machine:  
   `git clone https://github.com/AlexAntartico/my_dotfiles.git`

2. Review and edit the Bash and Vim config files to match your preferences.

3. Use the provided script to back up your dotfiles or to synchronize them across multiple systems.

4. Source your `aliases.sh` file from your `.bashrc` or `.bash_profile` for aliases and prompt customization:
   ```sh
   source ~/my_dotfiles/aliases.sh
   ```
5. Install Vim Plugins by downloading files from [https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim](here), then open Vim and running:
   ```sh
   :PlugInstall
   ```

---

## Notes
- Some commands require additional tools (e.g., htop, bat, fastfetch). Install them using your package manager as needed.
- Customize the script and config files to suit your environment.
- View the full list of managed files and scripts in the GitHub code search.
