local root=$HOMEBREW_ROOT
local etc=$root/etc
local share=$root/share

# autojump
if [ -s $share/autojump/autojump.zsh ]; then
  source $share/autojump/autojump.zsh
fi

# zsh-syntax-highlighting
if [ -s $share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source $share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
