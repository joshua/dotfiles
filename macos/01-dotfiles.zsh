# setup dotfiles
log::step "Installing dotfiles"

source $root/zsh/lib/df.zsh
local DF=$root
df::install
