ruby_prompt () {
  if which rvm-prompt &> /dev/null; then
    echo $(rvm-prompt i v g)
  elif which rbenv &> /dev/null; then
    echo $(rbenv version | awk '{ print $1 }')
  fi
}

go_prompt () {
  if which go &> /dev/null; then
    echo $(go version | awk '{ print $3 }')
  fi
}

export RPROMPT=$'%{$fg[blue]%}‹$(go_prompt)›%{$reset_color%}%{$fg[red]%}‹$(ruby_prompt)›%{$reset_color%}'
