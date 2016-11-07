export AWS_HOME=~/.aws

# AWS Profile helpers
function agp { echo $AWS_DEFAULT_PROFILE }
function asp { export AWS_DEFAULT_PROFILE=$1; export AWS_PROFILE=$1 }
function aws_profiles { echo $(grep profile $AWS_HOME/config|sed -e 's/.*profile \([a-zA-Z0-9_-]*\).*/\1/') }
function aws_profiles_comp { reply=($(aws_profiles)) }
compctl -K aws_profiles_comp asp

# Set default profile, if available
[ -r $AWS_HOME/default ] && asp $(cat $AWS_HOME/default)

# Load completions from homebrew
_aws_zsh_completer=$(brew --prefix awscli)/libexec/bin/aws_zsh_completer.sh
[ -x $_aws_zsh_completer ] && source $_aws_zsh_completer
unset _aws_zsh_completer

# validate cloudformation stack template
function cfv {
  [[ -n "$1" && -r "$1" ]] || return 1;
  aws cloudformation validate-template --template-body file://$1 1>/dev/null
}
