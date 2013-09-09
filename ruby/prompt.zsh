# Add current ruby to shell right prompt
ruby_prompt () {
  if which rvm-prompt &> /dev/null; then
    echo $(rvm-prompt i v g)
  elif which rbenv &> /dev/null; then
    echo $(rbenv version | awk '{ print $1 }')
  fi
}

export RPROMPT=$'%{$fg[red]%}‹$(ruby_prompt)›%{$reset_color%}'
