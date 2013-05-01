# RVM

# Load RVM into the shell
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Add current ruby to shell right prompt
local rvm=''
if which rvm-prompt &> /dev/null; then
  rvm='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
fi
RPROMPT="${rvm}"
unset rvm
