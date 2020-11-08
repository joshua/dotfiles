# Set GitHub Personal Access Token based on the curren't remote

set_github_token() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]]; then
        if [[ $(git remote get-url origin 2> /dev/null) =~ "code.ac.st" ]]; then
            token=${GITHUB_TOKEN_ENTERPRISE}
        else
            token=${GITHUB_TOKEN_GITHUB}
        fi
        export GITHUB_TOKEN=${token}
    fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd set_github_token
