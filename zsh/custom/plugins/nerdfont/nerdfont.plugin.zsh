for file in $(dirname $0)/*.sh; do
    test -f "$file" -a -r "$file" && source "$file" && echo $file
done
unset file
