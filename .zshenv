# The following lines were added by compinstall

# Extending file path, so I can run my own functions
fpath=(
    $HOME/scripts/functions
    $HOME/scripts/completions
    $HOME/scripts/apps
    $fpath
)

#export NIX_CONF_DIR="$HOME/.config/nix/"

. $HOME/.nix-profile/etc/profile.d/nix.sh


export PATH="$HOME/bin:$HOME/sources/factor/:$HOME/sources/sbt/bin:$HOME/.bin:/usr/local/texlive/2014/bin/x86_64-linux:$HOME/scripts:$HOME/servers/:$HOME/orientdb/releases/orientdb-1.5.1/bin:$HOME/.cabal/bin:$HOME/perl5/bin:$PATH";
export PYTHONPATH="$HOME/.nix-profile/lib/python2.7/site-packages:$PYTHONPATH"
export PYTHONPATH="$HOME/.nix-profile/lib/python2.7:$PYTHONPATH"
export LIBRARY_PATH="$HOME/.nix-profile/lib:$LIBRARY_PATH"
export EDITOR="/usr/local/bin/emacs.vim"

