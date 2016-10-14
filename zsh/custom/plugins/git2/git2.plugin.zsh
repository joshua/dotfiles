
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gs='git status -sb'
alias gst='git status -sb'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
