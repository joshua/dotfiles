## Aliases
alias reload!='. ~/.zshrc'

alias zshconfig="st ~/.zshrc"
alias ohmyzsh="st ~/.oh-my-zsh"

alias redis-start="redis-server /usr/local/etc/redis.conf"
alias memcache-start="/usr/local/opt/memcached/bin/memcached"

local _subl=/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl
alias st='${_subl} -n'
alias stt='st .'

alias c='clear'
alias cll='clear && ll'
alias cla='clear && la'
alias flushdns='sudo dscacheutil -flushcache' # OSX ipconfig /flushdns

## Directories
hash -d src=~/src
hash -d vnd=~src/vendor
hash -d legolab=~src/ACS/Lego/_lab

hash -d pg=$GOPATH/src/p.go
hash -d golab=$GOPATH/src/code.acs.tech/joshs/golab

hash -d corp=/Volumes/ACS/Corporate
hash -d xfer=/Volumes/ACS/Corporate/Transfer\ Location
