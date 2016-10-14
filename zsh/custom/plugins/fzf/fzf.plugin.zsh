# Setup fzf
# ---------
if [[ ! "$PATH" == */opt/boxen/homebrew/opt/fzf/bin* ]]; then
  export PATH="$PATH:/opt/boxen/homebrew/opt/fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */opt/boxen/homebrew/opt/fzf/man* && -d "/opt/boxen/homebrew/opt/fzf/man" ]]; then
  export MANPATH="$MANPATH:/opt/boxen/homebrew/opt/fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/opt/boxen/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/opt/boxen/homebrew/opt/fzf/shell/key-bindings.zsh"
