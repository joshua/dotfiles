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
# current version is different then the gobal.
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

POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs my_go_version my_rbenv my_aws time)

POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

POWERLEVEL9K_GO_VERSION_BACKGROUND="black"
POWERLEVEL9K_GO_VERSION_FOREGROUND="249"
POWERLEVEL9K_GO_VERSION_VISUAL_IDENTIFIER_COLOR="green"
POWERLEVEL9K_GO_ICON="\ue8ae"

POWERLEVEL9K_RBENV_BACKGROUND="black"
POWERLEVEL9K_RBENV_FOREGROUND="249"
POWERLEVEL9K_RBENV_VISUAL_IDENTIFIER_COLOR="red"

# POWERLEVEL9K_AWS_BACKGROUND="black"
# POWERLEVEL9K_AWS_FOREGROUND="249"
POWERLEVEL9K_AWS_VISUAL_IDENTIFIER_COLOR="yellow"

POWERLEVEL9K_TIME_BACKGROUND="black"
POWERLEVEL9K_TIME_FOREGROUND="249"
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S} \UE12E"
