# Load PoshGit shell prompt
# Currently bundled with GitHub for Windows
#
# TODO: Bundle PoshGit with dotfiles
#
. (Resolve-Path "$env:LOCALAPPDATA\GitHub\shell.ps1")
. $env:github_posh_git\profile.example.ps1
