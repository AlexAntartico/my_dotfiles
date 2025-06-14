# An alias is a shortcut or a custom command you can set up to represent a series of commands or a more complex command
# You should know these commands before committing to adopt their shortened version
# If  you need to run the original commands just do so by escaping the command, ie
# df here will run a df -hT but to run original df, do:
# \df and so on...
#
# Requirements: htop, bat
# sudo dnf5 install htop

alias reloadb='source ~/.bashrc'
# ls * --color=always may mess some i/o while piping, better to use --color-auto
alias ll='ls -lrth --color=auto'  # list, reverse order, timestamp, humar readalbe
alias la='ls -lrtha --color=auto'  # list, reverse order, timestamp, human readable, hidden file included
alias ld='ls -dlrth ./*'  # list directories in current directory
alias df='df -hT'  # sys space by share, human readable, system Type
alias d1='cd ..'
alias d2='cd ../..'
alias d3='cd ../../..'
alias d4='cd ../../../..'
alias upme='sudo dnf5 upgrade -y'  # me being lazy
alias py_gitignore='curl https://raw.githubusercontent.com/github/gitignore/main/Python.gitignore > ./.gitignore'  # me being super practical
alias top='/usr/bin/htop'
alias less='less -N'  # I like my less command w/line numbers
alias cat='/usr/bin/bat'  # bat is like a less command but with colors
alias grep='/usr/bin/grep --color=auto -n'

# prompt line  will look like:
# 14:25:33 [user@hostname] /current/working/directory
export PS1="\t \[\e[35m\][\[\e[m\]\[\e[36m\]\u\[\e[m\]@\[\e[34m\]\h\[\e[m\]\[\e[35m\]]\[\e[m\] \[\e[33m\]\w\[\e[m\]\n"  # I like this format, refer to https://ezprompt.net/

# everytime your teminal loads, will run a fastfetch. You can also substitute with the pokemon though, looks cool
fastfetch
