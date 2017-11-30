# setup dotfiles
log::step "Installing dotfiles"

source $root/zsh/lib/df.zsh
local DF=$root
df::install

log::step "Changing shell to ZSH for $USER"
local shell=$(dscl . -read /Users/$USER UserShell | awk '{ print $2}')
if [[ ! "$shell" = "zsh" ]]; then
  sudo chsh -s zsh $USER
else
  log::g "shell already set to zsh for user $USER"
fi
