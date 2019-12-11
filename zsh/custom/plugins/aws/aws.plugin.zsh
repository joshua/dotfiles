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

function aws-reset {
    [[ -n "${1}" ]] || return 1;
    p=$(aws secretsmanager get-random-password --password-length 20 --require-each-included-type --output text)
    aws iam update-login-profile --user-name ${1} --password "${p}" --password-reset-required
    if [ $? -eq 0 ]; then
        payload="$(urlencode ${p})"
        exp_days=3
        exp_views=5
        data="password%5Bpayload%5D=${payload}&password%5Bexpire_after_days%5D=3&password%5Bexpire_after_views%5D=5&password%5Bdeletable_by_viewer%5D=on&="
        resp=$(curl -s --request POST \
             --url 'https://pwpush.com/p.json' \
             --header 'content-type: application/x-www-form-urlencoded' \
             --header 'accept: text/html,application/xhtml+xml,application/xml' \
             --data "${data}")
        if [ $? -eq 0 ]; then
            token=$(echo ${resp} | tr '\n' ' ' | jq -r '.url_token')
            url="https://pwpush.com/p/${token}"
            echo ${url} | pbcopy
            echo ${url}
        fi
    fi
}
