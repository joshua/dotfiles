#!/bin/zsh

export PATH="$PATH:$HOME/src/go/bin"

function hacking_effect() {
    hacking_effect2 $1 $2
}

# Hacking effect function
function hacking_effect1() {
  local lines=$1
  local delay=$2
  for ((i = 1; i <= lines; i++)); do
    random_string=$(openssl rand -hex 32)
    echo -e "\033[32m$random_string\033[0m"
    sleep $delay
  done
}

function hacking_effect2() {
  local lines=$1   # Number of lines to display
  local delay=$2   # Delay between lines in seconds
  echo
  for ((i = 1; i <= lines; i++)); do
    random_string=$(LC_CTYPE=C tr -cd '[:graph:]' < /dev/urandom | head -c 64)
    echo -e "\033[32m$random_string\033[0m"
    sleep $delay
  done
  echo
}