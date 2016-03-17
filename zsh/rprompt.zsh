ruby_prompt () {
  if which rvm-prompt &> /dev/null; then
    echo $(rvm-prompt i v g)
  elif which rbenv &> /dev/null; then
    echo $(rbenv version | awk '{ print $1 }')
  fi
}

go_prompt () {
  if which go &> /dev/null; then
    local version=$(go version | awk '{ print $3 }')
    echo ${version#"go"}
  fi
}

nodejs_prompt () {
  if which nodenv &> /dev/null; then
    echo $(nodenv version-name | awk '{ print $1 }')
  fi
}

export RPROMPT=$'%{$fg[blue]%}‹$(go_prompt)›%{$reset_color%}%{$fg[red]%}‹$(ruby_prompt)›%{$reset_color%}%{$fg[green]%}‹$(nodejs_prompt)›%{$reset_color%}'
