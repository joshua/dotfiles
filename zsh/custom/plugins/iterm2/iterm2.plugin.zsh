# iTerm2 Shell Integration
# https://www.iterm2.com/documentation-shell-integration.html
for file in $(dirname $0)/*.sh; do
  source $file
done
