#
# Teh H4xx
#

if [ "$(uname)" = "Darwin" ]; then
  # Suppress unwanted Homebrew-installed stuff.
  if [ -e /usr/local/share/zsh/site-functions/_git ]; then
    mv -f /usr/local/share/zsh/site-functions/{,disabled.}_git
  fi
fi

#
# Completion
#

autoload -U compinit
compinit -u

# Make completion:
# - Case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''

#
# Correction
#

# exceptions to auto-correction
# alias bundle='nocorrect bundle'
# alias cabal='nocorrect cabal'
# alias man='nocorrect man'
# alias mkdir='nocorrect mkdir'
# alias mv='nocorrect mv'
# alias stack='nocorrect stack'
# alias sudo='nocorrect sudo'

#
# Prompt
#

autoload -U colors
colors

# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "%F{green}●%f" # default 'S'
zstyle ':vcs_info:*' unstagedstr "%F{red}●%f" # default 'U'
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:git+set-message:*' hooks git-untracked
zstyle ':vcs_info:git*:*' formats '[%b%m%c%u] ' # default ' (%s)-[%b]%c%u-'
zstyle ':vcs_info:git*:*' actionformats '[%b|%a%m%c%u] ' # default ' (%s)-[%b|%a]%c%u-'
zstyle ':vcs_info:hg*:*' formats '[%m%b] '
zstyle ':vcs_info:hg*:*' actionformats '[%b|%a%m] '
zstyle ':vcs_info:hg*:*' branchformat '%b'
zstyle ':vcs_info:hg*:*' get-bookmarks true
zstyle ':vcs_info:hg*:*' get-revision true
zstyle ':vcs_info:hg*:*' get-mq false
zstyle ':vcs_info:hg*+gen-hg-bookmark-string:*' hooks hg-bookmarks
zstyle ':vcs_info:hg*+set-message:*' hooks hg-message

function +vi-hg-bookmarks() {
  emulate -L zsh
  if [[ -n "${hook_com[hg-active-bookmark]}" ]]; then
    hook_com[hg-bookmark-string]="${(Mj:,:)@}"
    ret=1
  fi
}

function +vi-hg-message() {
  emulate -L zsh

  # Suppress hg branch display if we can display a bookmark instead.
  if [[ -n "${hook_com[misc]}" ]]; then
    hook_com[branch]=''
  fi
  return 0
}

function +vi-git-untracked() {
  emulate -L zsh
  if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
    hook_com[unstaged]+="%F{blue}●%f"
  fi
}

# TODO: make this work correctly
function short_pwd() {
    cwd=$(pwd | perl -F/ -ane 'print join( "/", map { $i++ < @F - 1 ?  substr $_,0,1 : $_ } @F)')
    echo -n $cwd
}

# RPROMPT_BASE="\${vcs_info_msg_0_}%F{blue}%~%f"
RPROMPT_BASE="\${vcs_info_msg_0_}%f%~"
# RPROMPT_BASE="\${vcs_info_msg_0_}[%*]" # current time 24-hour format w/ seconds
setopt PROMPT_SUBST
# Note use a non-breaking space at the end of the prompt because we can use it as
# a find pattern to jump back in tmux.
# export PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%1~%(?..%F{yellow}%B!%b%f)%F{red}%B%(!.#.$)%b%f "

function () {
  if [[ -n "$TMUX" ]]; then
    local LVL=$(($SHLVL - 1))
  else
    local LVL=$SHLVL
  fi
  if [[ $EUID -eq 0 ]]; then
    local SUFFIX=$(printf '#%.0s' {1..$LVL})
  else
    local SUFFIX=$(printf '\$%.0s' {1..$LVL})
  fi
  if [[ -n "$TMUX" ]]; then
    # Note use a non-breaking space at the end of the prompt because we can use it as
    # a find pattern to jump back in tmux.
    local NBSP=' '
    export PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{yellow}%B%(1j.*.)%(?..!)%b%f%F{blue}%B${SUFFIX}%b%f${NBSP}"
    export ZLE_RPROMPT_INDENT=0
  else
    # Don't bother with ZLE_RPROMPT_INDENT here, because it ends up eating the
    # space after PS1.
    export PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{yellow}%B%(1j.*.)%(?..!)%b%f%F{blue}%B${SUFFIX}%b%f "
  fi
}

# First part sets an exclamation mark if previous command failed (exited) badly
# export PS1="%(?..%F{yellow}%B!%b%f)%F{blue}❯%f "
export RPROMPT=$RPROMPT_BASE
export SPROMPT="zsh: correct %F{red}'%R'%f to %F{red}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "

#
# History
#

export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

#
# Options
#

# setopt autocd               # .. is shortcut for cd .. (etc)
setopt autoparamslash       # tab completing directory appends a slash
# setopt autopushd            # cd automatically pushes old dir onto dir stack
setopt clobber              # allow clobbering with >, no need to use >!
setopt correct              # command auto-correction
setopt correctall           # argument auto-correction
setopt noflowcontrol        # disable start (C-s) and stop (C-q) characters
setopt nonomatch            # unmatched patterns are left unchanged
setopt histignorealldups    # filter duplicates from history
setopt histignorespace      # don't record commands starting with a space
setopt histverify           # confirm history expansion (!$, !!, !foo)
setopt ignoreeof            # prevent accidental C-d from exiting shell
setopt interactivecomments  # allow comments, even in interactive shells
setopt noclobber
setopt printexitvalue       # for non-zero exit status
# setopt pushdignoredups      # don't push multiple copies of same dir onto stack
setopt pushdsilent          # don't print dir stack after pushing/popping
setopt sharehistory         # share history across shells

#
# Bindings
#

bindkey -e # emacs bindings, set to -v for vi bindings
# bindkey -v # vim bindings

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "\e[A" history-beginning-search-backward-end  # cursor up
bindkey "\e[B" history-beginning-search-forward-end   # cursor down

autoload -U select-word-style
select-word-style bash # only alphanumeric chars are considered WORDCHARS

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

bindkey ' ' magic-space # do history expansion on space

# Replace standard history-incremental-search-{backward,forward} bindings.
# These are the same but permit patterns (eg. a*b) to be used.
bindkey "^r" history-incremental-pattern-search-backward
bindkey "^s" history-incremental-pattern-search-forward

# Make CTRL-Z background things and unbackground them.
function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N fg-bg
bindkey '^Z' fg-bg

#
# Other
#

source $HOME/.config/zsh/aliases
source $HOME/.config/zsh/functions
source $HOME/.config/zsh/exports

if [ -d "$HOME/.local/bin" ] ; then
    case ":$PATH:" in
        *":$HOME/.local/bin:"*) :;; # already there
        *) PATH="$PATH:$HOME/.local/bin";;
    esac
fi

if [ -d "$HOME/.cabal/bin" ] ; then
    case ":$PATH:" in
        *":$HOME/.cabal/bin:"*) :;; # already there
        *) PATH="$PATH:$HOME/.cabal/bin";;
    esac
fi

#
# Hooks
#

autoload -U add-zsh-hook

# typeset -F SECONDS
# function record-start-time() {
#   emulate -L zsh
#   ZSH_START_TIME=${ZSH_START_TIME:-$SECONDS}
# }

# add-zsh-hook preexec record-start-time

# function report-start-time() {
#   emulate -L zsh
#   if [ $ZSH_START_TIME ]; then
#     local DELTA=$(($SECONDS - $ZSH_START_TIME))
#     local DAYS=$((~~($DELTA / 86400)))
#     local HOURS=$((~~(($DELTA - $DAYS * 86400) / 3600)))
#     local MINUTES=$((~~(($DELTA - $DAYS * 86400 - $HOURS * 3600) / 60)))
#     local SECS=$(($DELTA - $DAYS * 86400 - $HOURS * 3600 - $MINUTES * 60))
#     local ELAPSED=''
#     test "$DAYS" != '0' && ELAPSED="${DAYS}d"
#     test "$HOURS" != '0' && ELAPSED="${ELAPSED}${HOURS}h"
#     test "$MINUTES" != '0' && ELAPSED="${ELAPSED}${MINUTES}m"
#     if [ "$ELAPSED" = '' ]; then
#       SECS="$(print -f "%.2f" $SECS)s"
#     elif [ "$DAYS" != '0' ]; then
#       SECS=''
#     else
#       SECS="$((~~$SECS))s"
#     fi
#     ELAPSED="${ELAPSED}${SECS}"
#     export RPROMPT="%F{blue}${ELAPSED}%f $RPROMPT_BASE"
#     unset ZSH_START_TIME
#   else
#     export RPROMPT="$RPROMPT_BASE"
#   fi
# }

# add-zsh-hook precmd report-start-time

function auto-ls-after-cd() {
  emulate -L zsh
  # Only in response to a user-initiated `cd`, not indirectly (eg. via another
  # function).
  if [ "$ZSH_EVAL_CONTEXT" = "toplevel:shfunc" ]; then
    ls -AFG
  fi
}
add-zsh-hook chpwd auto-ls-after-cd

# for prompt
add-zsh-hook precmd vcs_info

# adds `cdr` command for navigating to recent directories
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# enable menu-style completion for cdr
zstyle ':completion:*:*:cdr:*:*' menu selection

# fall through to cd if cdr is passed a non-recent dir as an argument
zstyle ':chpwd:*' recent-dirs-default true

# local and host-specific overrides

HOST_RC=$HOME/.zsh/host/$(hostname -s)
test -f $HOST_RC && source $HOST_RC

LOCAL_RC=$HOME/.zshrc.local
test -f $LOCAL_RC && source $LOCAL_RC

#
# /etc/motd
#

if [ -e /etc/motd ]; then
  if ! cmp -s $HOME/.hushlogin /etc/motd; then
    tee $HOME/.hushlogin < /etc/motd
  fi
fi
