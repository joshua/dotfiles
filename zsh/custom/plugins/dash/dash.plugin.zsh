
dash() {
  if [ ! -n "$1" ]; then
    echo "$0 [keyword:]{query}"
    return 1
  fi
  open "dash://$1"
}

dg() { dash go:$1 }

alias dq="dash"
