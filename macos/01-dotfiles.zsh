# setup dotfiles
log::step "Installing dotfiles"

source $root/zsh/lib/df.zsh
local DF=$root
df::install

log::step "Changing shell to ZSH for $USER"
sudo chsh -s zsh $USER
