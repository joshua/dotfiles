# bullet train
# ZSH_THEME="bullet-train"
#
# BULLETTRAIN_AWS_FG=243 # light grey
# BULLETTRAIN_AWS_SHOW=true
# BULLETTRAIN_DIR_EXTENDED=2
# BULLETTRAIN_EXEC_TIME_SHOW=true
# BULLETTRAIN_GIT_ADDED=" 👶"
# BULLETTRAIN_GIT_AHEAD=" 👆"
# BULLETTRAIN_GIT_BEHIND=" 👇"
# BULLETTRAIN_GIT_CLEAN=" ✔"
# BULLETTRAIN_GIT_COLORIZE_DIRTY_BG_COLOR=242
# BULLETTRAIN_GIT_COLORIZE_DIRTY_FG_COLOR=white #209
# BULLETTRAIN_GIT_COLORIZE_DIRTY=true
# BULLETTRAIN_GIT_DELETED=" 💣"
# BULLETTRAIN_GIT_DIRTY=" 💩"
# BULLETTRAIN_GIT_DIVERGED=" ⛓"
# BULLETTRAIN_GIT_MODIFIED=" ✏️"
# BULLETTRAIN_GIT_RENAMED=" 🚚"
# BULLETTRAIN_GIT_UNTRACKED=" 👀"
# BULLETTRAIN_GO_PREFIX=""
# BULLETTRAIN_GO_SHOW=true
# BULLETTRAIN_NVM_PREFIX=""
# BULLETTRAIN_NVM_SHOW=false
# BULLETTRAIN_PROMPT_CHAR="🐐" # 👉 💰
# BULLETTRAIN_RUBY_PREFIX=""
# BULLETTRAIN_RUBY_SHOW=false
# BULLETTRAIN_STATUS_EXIT_SHOW=true

# powerlevel9k
ZSH_THEME="powerlevel9k/powerlevel9k"

# only show the go version if within GOPATH
prompt_my_go_version() {
  [ ! -n $GOPATH ] && return
  if [[ "$(pwd)" == ("$GOPATH")* ]]; then
    local go_version=$(go version 2>/dev/null | awk '{print substr($3,3)}')
    [[ -n "$go_version" ]] && "$1_prompt_segment" "prompt_go_version" "$2" "green" "255" "$go_version" "GO_ICON"
  fi
}

# if the current aws profile is not the default, change the color
prompt_my_aws() {
  local aws_profile="$AWS_DEFAULT_PROFILE"
  if [ -n "$aws_profile" ]; then
    local color=(black 249)
    local default

    if [[ -a ~/.aws/default ]]; then
      default=$(cat ~/.aws/default)
    fi

    if [[ -n "$default" && ("$aws_profile" != "$default") ]]; then
      color=(red white)
    fi

    "$1_prompt_segment" "prompt_aws" "$2" $color[1] $color[2] "$aws_profile" 'AWS_ICON'
  fi
}

# only show the ruby version if there is a local .ruby-version file or the
# current version is different then the global.
prompt_my_rbenv() {
  if which rbenv 2>/dev/null >&2; then
    local rbenv_version_name="$(rbenv version-name)"
    local rbenv_global="$(rbenv global)"
    local rbenv_version_file=$(rbenv version-file)
    local cwd=$(pwd)

    if [[ $rbenv_version_name == $rbenv_global && $cwd != ($rbenv_version_file:a:h)* ]]; then
      return
    fi

    "$1_prompt_segment" "rbenv" "$2" "red" "$DEFAULT_COLOR" "$rbenv_version_name" 'RUBY_ICON'
  fi
}

prompt_my_cross() {
  "$1_prompt_segment" "prompt_cross" "$2" "black" "white" "" "CROSS_ICON"
}

POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(my_cross context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs my_go_version my_rbenv my_aws time)

POWERLEVEL9K_CROSS_ICON="\uc001"

POWERLEVEL9K_FOLDER_ICON="\uf07b"
POWERLEVEL9K_HOME_ICON="\uf015"
POWERLEVEL9K_HOME_SUB_ICON="\uf07c"

POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

POWERLEVEL9K_GO_VERSION_BACKGROUND="black"
POWERLEVEL9K_GO_VERSION_FOREGROUND="249"
POWERLEVEL9K_GO_VERSION_VISUAL_IDENTIFIER_COLOR="green"
# POWERLEVEL9K_GO_ICON="\ue8ae"
POWERLEVEL9K_GO_ICON="\ue626"

POWERLEVEL9K_RBENV_BACKGROUND="black"
POWERLEVEL9K_RBENV_FOREGROUND="249"
POWERLEVEL9K_RBENV_VISUAL_IDENTIFIER_COLOR="red"

# POWERLEVEL9K_AWS_BACKGROUND="black"
# POWERLEVEL9K_AWS_FOREGROUND="249"
POWERLEVEL9K_AWS_VISUAL_IDENTIFIER_COLOR="yellow"
# POWERLEVEL9K_AWS_ICON="\ue79b"
POWERLEVEL9K_AWS_ICON="\uf52d"
# POWERLEVEL9K_AWS_ICON="\uf1b3"
# POWERLEVEL9K_AWS_ICON="\uf270"

POWERLEVEL9K_TIME_BACKGROUND="black"
POWERLEVEL9K_TIME_FOREGROUND="249"
# POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S} \uf017"
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S}"

POWERLEVEL9K_VCS_GIT_ICON="\uf113"
POWERLEVEL9K_VCS_BRANCH_ICON="\ue725 "
POWERLEVEL9K_VCS_UNTRACKED_ICON="\uf059"
POWERLEVEL9K_VCS_UNSTAGED_ICON="\uf0e7"
POWERLEVEL9K_VCS_STAGED_ICON="\uf055"
POWERLEVEL9K_VCS_STASH_ICON="\uf01c"
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON="\uf431"
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON="\uf433"
