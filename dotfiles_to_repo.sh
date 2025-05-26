#!/usr/bin/bash

# =============================================================================================
# SCRIPT: dotfiles_to_repo.sh
#
# USAGE:
#   1. CONFIGURE: Modify the "USER CONFIGURATION" section below
#   2. EXECUTE: ./dotfiles_to_repo.sh
#
# DESCRIPTION:
# This script copies specified dotfiles from the your home directory to a designated local repository directory. Useful for:
#   - Backing up dotfiles in a VCS
#   - Synchronizing dotfiles across multiple machines
#   - Sharing a template for others to manage their dotfiles
#
# HOW IT WORKS:
# 1. Define the dotfiles you want to copy and their full paths.
# 2. Define your local repository path.
# 3. Script will check if repo exists and its writable.
# 4. It will then iterate over the dotfiles
#   - confimr dotfile exists and is writable
#   - cp -uv (u to confirm if sources is newer than destination, v for verbose)
#
# FIRST USE:
#   - I assume you have bash shell and cp command available.
#   - Make this script executable: chmod +x dotfiles_to_repo.sh
#   - Edit the USER CONFIGURATION section below

# 1. Dotfiles to copy
# Define the full paths to your dotfiles. Use format: var_name="$HOME/PATH/TO/FILE"
#
# Common locations:
# bashrc: $HOME/.bashrc in most linux distributions
# bashrc: $HOME/.bashrc.d/aliases.sh or bashrc in fedora
# kitty: $HOME/.config/kitty/kitty.conf
# vim: $HOME/.vimrc or $HOME/.config/nvim/init.vim

# =============================================================================================
# USER CONFIGURATION STARTS HERE
# 1. Define your dotfiles paths
my_aliases="$HOME/path/to/aliases.sh"  # <-- Edit this line to your aliases file
my_kitty="$HOME/path/to/kitty.conf"  # <-- Edit this line to your kitty config
my_vim="$HOME/.vimrc"  # <-- Edit this line to your vim config
# my_another_config="$HOME/path/to/another_config"

# array with dotfiles
# list all vars defined above
dotfiles=("$my_aliases" "$my_kitty" "$my_vim")

# 2. Define your repository path
repo_path="$HOME/repos/my_dotfiles"  # <-- Edit this line to your repository path
# USER CONFIGURATION ENDS HERE
# =============================================================================================

# --- Script starts here ---

# 3. Check if the repository path exists and is writable
if [[ ! -d "$repo_path" ]]; then
    echo "Repository path $repo_path does not exist. Creating it now."
    mkdir -p "$repo_path"
    if [[ $? -ne 0 ]]; then
        echo "Failed to create repository path $repo_path. Exiting."
        exit 1
    fi
    chmod u+w "$repo_path"  # Ensure it's writable
fi

echo "Target repo path: $repo_path"
echo -e "Dotfiles to copy: ${dotfiles[*]}\n"

# 4. Iterate over the dotfiles and copy them to the repository
for file in "${dotfiles[@]}"; do
    echo -e "Copying $file to $repo_path\n"
    # Check if the file exists before copying
    if [[ -f "$file" ]]; then
        cp -uv "$file" "$repo_path"
    else
        echo "File $file does not exist, skipping."
    fi
done
echo -e "\nAll dotfiles copied to $repo_path"

# End of script

