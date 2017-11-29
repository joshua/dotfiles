setopt extended_glob
autoload -U colors && colors

source $root/zsh/oh-my-zsh/lib/spectrum.zsh

# banner
banner::print() {
  printf '%s\n' '    __ _ _           '
  printf '%s\n' '   / _(_) |          '
  printf '%s\n' '  | |_ _| | ___  ___ '
  printf '%s\n' '  |  _| | |/ _ \/ __|'
  printf '%s\n' ' _| | | | |  __/\__ \'
  printf '%s\n' '(_)_| |_|_|\___||___/'
  printf '\n'
}

# logging
log::r() { print -P -- "%{$BG[001]%}%{$FG[000]%}$1%{$reset_color%}" }
log::g() { print -P -- "%{$BG[002]%}%{$FG[000]%}$1%{$reset_color%}" }
log::y() { print -P -- "%{$BG[003]%}%{$FG[000]%}$1%{$reset_color%}" }
log::b() { print -P -- "%{$BG[004]%}%{$FG[000]%}$1%{$reset_color%}" }
log::n() { print -P -- "%{$BG[000]%}%{$FG[007]%}$1%{$reset_color%}" }

log::step() { log::n "\n>>>>> $*" }
log::panic() { log::r $1; exit 1 }

# utility functions
macos::version() { echo -E $(sw_vers -productVersion) }
macos::ensure_version() { [[ $(macos::version) =~ "^$1" ]] }
macos::check_group() {
  local o=$(dsmemberutil checkmembership -U "$USER" -G "$1")
  [[ "$o" =~ "is a member" ]]
}
