# dotfiles

configuration files

to copy into home directory

~~~~
git clone --separate-git-dir=$HOME/.dotfiles /path/to/repo $HOME/dotfiles-tmp
rm -r ~/dotfiles-tmp/
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
~~~~
