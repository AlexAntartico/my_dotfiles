# ── CachyOS Zsh base ──────────────────────────────────────
# source /usr/share/cachyos-zsh-config/cachyos-config.zsh
# Load CachyOS Zsh config (local override, p10k disabled)
if [[ -f ~/.config/zsh/cachyos-config.zsh ]]; then
  source ~/.config/zsh/cachyos-config.zsh
fi
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true  # TO DISABLE POWERLEVEL10K AS WE HAVE STARSHIP
unset POWERLEVEL9K_CONFIG_FILE
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# ── Environment ───────────────────────────────────────────
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"

# ── Starship prompt ───────────────────────────────────────
eval "$(starship init zsh)"

# ── zoxide (smart cd) ─────────────────────────────────────
eval "$(zoxide init zsh)"

# ── fzf keybindings ───────────────────────────────────────
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# ── Aliases ───────────────────────────────────────────────
alias ls='lsd'
alias ll='lsd -la'
alias lt='lsd --tree'
alias la='lsd -lrha'

alias top='btop'
alias pseint='/opt/pseint/pseint'
alias rldshell='source ~/.zshrc'
alias sshadd='ssh-add ~/.ssh/id_ed25519 && ssh-add -l'

alias lg='lazygit'

alias devmon='tmux new-window -n monitor \; \
  send-keys "btop" Enter \; \
  split-window -h \; \
  send-keys "lg" Enter'
# ── Starship prompt cleanup ───────────────────────────────
RPROMPT=''
RPS1=''
PROMPT_EOL_MARK=''

# ── Zsh quality of life ───────────────────────────────────
setopt AUTO_CD
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
