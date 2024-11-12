# GRC colorizes nifty unix tools all over the place
if $(grc &>/dev/null) && ! $(brew &>/dev/null); then
  source $HOMEBREW_ROOT/etc/grc.zsh

  # grc causes issues with interactive prompts.
  # (docker -it, pprof, etc)
  # unalias make
fi
