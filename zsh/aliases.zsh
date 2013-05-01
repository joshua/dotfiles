## Aliases
alias reload!='. ~/.zshrc'

alias zshconfig="st ~/.zshrc"
alias ohmyzsh="st ~/.oh-my-zsh"

alias redis-start="redis-server /usr/local/etc/redis.conf"
alias memcache-start="/usr/local/opt/memcached/bin/memcached"

local _subl=/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl
alias st='${_subl} -n'
alias stt='st .'

alias c='clear'
alias cll='clear && ll'
alias cla='clear && la'
alias flushdns='sudo dscacheutil -flushcache' # OSX ipconfig /flushdns
