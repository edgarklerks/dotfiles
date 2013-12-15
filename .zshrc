
# Caching

zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path ~/.zshcache
zstyle ':completion:*' add-space true

# Completers loaded
zstyle ':completion:*' completer _list _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-grouped
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'm:{[:lower:]}={[:upper:]} l:|=* r:|=*'
zstyle ':completion:*' match-original both
zstyle ':completion:*' max-errors 2 numeric
zstyle ':completion:*' menu yes select
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt 'Errors found %e'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle ':completion:*' word true
zstyle :compinstall filename '$HOME/.zshrc'


autoload -Uz compinit
compinit


# Color ls output

eval `dircolors ~/.dir_colors`

alias ls='ls --color=auto'



# End of lines added by compinstall
# Lines configured by zsh-newuser-install

# I like to use ZSH as calculator
zmodload zsh/mathfunc

HISTFILE=~/.histfile
HISTSIZE=6000
SAVEHIST=6000
setopt appendhistory autocd extendedglob nomatch notify hist_expire_dups_first extended_history share_history inc_append_history hist_find_no_dups auto_pushd pushd_silent pushd_ignore_dups bang_hist multios
unsetopt beep
bindkey -v

# End of lines configured by zsh-newuser-install

# Local perl lib
export PERL_LOCAL_LIB_ROOT="$HOME/perl5";
export PERL_MB_OPT="--install_base $HOME/perl5";
export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5";
export PERL5LIB="$HOME/perl5/lib/perl5/i686-linux-gnu-thread-multi-64int:$HOME/perl5/lib/perl5";
export MANPATH="/usr/local/texlive/2013/texmf-dist/doc/man:$MANPATH:$HOME/.nix-profile/share/man"
export INFOPATH="/usr/local/texlive/2013/texmf-dist/doc/info:$MANPATH"

# Dynamic changing prompt
# and customized prompt
autoload -Uz myprompt
myprompt

function chpwd {
    dynamic_prompt
}

# Partitioned periodic functions
# Runs functions interleaved

autoload -U periodicity
periodicity

# Periodic functions
# this one runs 5 in 10
# and updates the prompt

function 5_in_10 {
    dynamic_prompt
}

function periodic {
    periodicity
}

PERIOD=1

# Load my aliases
autoload -U aliases
aliases

# Load keybindings tweaks

autoload -U keybindings
keybindings

# Compile often used scripts
autoload -U zrecompile

autoload -Uz colorify

zrecompile -p \
        -R ~/.zshrc -- \
        -R ~/vimscripts/line.sh -- \
        -R ~/scripts/reset_repos.zsh -- \
        -R ~/scripts/functions/aliases -- \
        -R ~/scripts/functions/branching -- \
        -R ~/scripts/functions/myprompt -- \
        -R ~/scripts/functions/periodicity -- \
        -R ~/scripts/functions/spinner -- \
        -R ~/scripts/functions/keybindings

function run_server {
        autoload -U chatserver
        chatserver
        rm /tmp/test-socket
        start_server "test"
}

function run_client {
        autoload -U chatserver
        chatserver
        start_client "test"
}
function sman {
        param=$1
        sections=(${(s:.:)param})
        man $sections[1] $sections[2]
}

# Load some stuff which enables concatenative programming

autoload -Uz functional
functional

autoload -Uz macro

# Preexec hooks
function preexec {
        macro $1 $2 $3
}


autoload -Uz channel
channel

autoload -Uz keydb
keydb

# Antigen bundles

source ~/sources/zsh/antigen.zsh
# antigen use oh-my-zsh
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zaw

antigen bundle command-not-found
antigen bundle Tarrasch/zsh-bd
antigen bundle extract
antigen bundle vagrant
antigen bundle vagrant
antigen bundle debian
antigen bundle colored-man
antigen bundle zsh-users/zsh-completions

antigen apply
