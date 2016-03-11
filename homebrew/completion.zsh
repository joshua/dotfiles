_completions=(
  '_aws'
)

for _c in "${_completions[@]}"; do
  completion="$(brew --prefix)/share/zsh/site-functions/$_c"
  test -f $completion && source $completion
done
