hex2decimal() { echo "ibase=16; $@" | bc }
decimal2hex() { echo "obase=16; $@" | bc }

alias h2d=hex2decimal
alias d2h=decimal2hex
