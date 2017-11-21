
# array-to-quote() {
#     autoload -U modify-current-argument
#     modify-current-argument '$(
#         if [[ ${(Pt)ARG} = "array" ]]; then
#             print ${(j., .)${(qq)${(P)ARG}}}
#         elif [[ -r $ARG ]]; then
#             # print ${(j., .)${(qq)${(f)"$(<$ARG)"}}}
#             print ${ARG:a}
#         else
#             print ${ARG}
#         fi
#     )'
# }
# zle -N array-to-quote
# # Terminal: Stop stealing CTRL-q and CTRL-s!
# stty start '^-' stop '^-'
# bindkey "^q" array-to-quote

# expand-file-urls() {
#     autoload -U modify-current-argument
#     modify-current-argument '$(
#       local prefix="file://"
#       local file=${ARG#$prefix}
#       if [[ ${ARG} == ($prefix)* && -a $file ]]; then
#         print ${prefix}${file:a}
#       else
#         print ${ARG}
#       fi
#     )'
# }
# zle -N expand-file-urls
# bindkey "^x" expand-file-urls


# git clone magic
# zle -N bracketed-paste git-clone-magic
