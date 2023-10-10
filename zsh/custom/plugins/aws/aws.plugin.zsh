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

function ec2q {
    [[ -n "${1}" ]] || return 1;

    local output query remote user file
    local -a pairs
    local -A options

    output="table"
    pairs=(
        "Id:InstanceId"
        "IP:PrivateIpAddress"
        "State:State.Name"
        "AZ:Placement.AvailabilityZone"
        "Name:Tags[?Key==\`Name\`].Value|[0]"
        "DataDog:Tags[?Key==\`datadog\`].Value|[0]"
        "Type:InstanceType"
        "LaunchTime:LaunchTime"
        "AMI:ImageId"
        "Platform:Platform"
    )
    query="Reservations[*].Instances[*].{${(j:,:)pairs}}"

    zparseopts -D -E -A options -- t id ip 1 s:: rmt:: f::
    
    # --filters "Name=instance-state-name,Values=running" "Name=tag:Name,Values=*${1}*" \
    # --filters "Name=tag:Name,Values=*${1}*" \
    filters="Name=tag:Name,Values=*${1}*"

    for opt in "${(k@)options}"; do
        case "${opt}" in
            "-t" ) # filter by instance type
                filters="Name=instance-type,Values=${1}*"
                ;;
            "-id" ) # filter by instance id
                filters="Name=instance-id,Values=${1}"
                ;;
            "-1" ) # print the full JSON for the first result
                output="json"
                query="Reservations[0].Instances[0]"
                ;;
            "-ip" ) # only print IP addresses
                output="text"
                query="Reservations[*].Instances[*].[PrivateIpAddress]"
                ;;
            "-s" ) # state option
                filters+=""
                ;;
            "-rmt" ) # print user@ip for each host with the given user name
                remote=1
                user="${options}"
                [[ -n "${user}" ]] || { echo "-u must be defined with -rmt" && return 1 }
                output="text"
                query="Reservations[*].Instances[*].[PrivateIpAddress]"
                ;;
        esac
    done

    # cmd="aws ec2 describe-instances --filters \"${filters}\" --query \"${query}\" --output \"${output}\""
    # echo "[${cmd}]"
    res=$(aws ec2 describe-instances --filters "${filters}" --query "${query}" --output "${output}")

    if [ "${remote}" = "1" ]; then
        for ip in ${(f)res}; do
            echo "${user}@${ip}"
        done
        return 0
    fi

    echo "${res}"
}
