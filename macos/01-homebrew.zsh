# install Homebrew
log::step "Installing Homebrew"

local brew_prefix="/usr/local"
local brew_repo="/usr/local/Homebrew"

[ -d "$brew_prefix" ] || sudo mkdir -p "$brew_prefix"
[ -d "$brew_repo" ] || sudo mkdir -p "$brew_repo"

sudo chown root:wheel $brew_prefix 2>/dev/null || true
sudo chown -R "$USER:admin" $brew_repo || true

for d in Cellar Frameworks bin etc include lib opt sbin share var
do
  [ -d $brew_prefix/$d ] || sudo mkdir -p $brew_prefix/$d
  sudo chown -R "$USER:admin" $brew_prefix/$d
done

(
  cd $brew_repo

  git init -q
  git config remote.origin.url "https://github.com/Homebrew/brew"
  git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
  git config core.autocrlf "false"
  git fetch origin master:refs/remotes/origin/master -n
  git reset --hard origin/master

  ln -sf $brew_repo/bin/brew $brew_prefix/bin/brew

  $brew_prefix/bin/brew update --force
)

# install and upgrade from Brewfile
if [ -f "$HOME/.Brewfile" ]; then
  log::step "Installing from Brewfile"
  brew bundle check --global || brew bundle --global
  log::g "Brews installed/updated"
fi
