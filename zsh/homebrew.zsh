export HOMEBREW_ROOT=/opt/homebrew
export HOMEBREW_CACHE=$HOME/Library/Caches/Homebrew

export CFLAGS="-I$HOMEBREW_ROOT/include"
export LDFLAGS="-L$HOMEBREW_ROOT/lib"

export PATH=$HOMEBREW_ROOT/bin:$HOMEBREW_ROOT/sbin:$PATH
export MANPATH=$HOMEBREW_ROOT/share/man:$MANPATH
