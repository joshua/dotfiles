################################################################################
## Directories

# hashdir adds the given parameters to the direction hash table
# and creates an alias of the same name that skips command correction
##
# hashdir $1:alias $2:path
#
function hashdir() { hash -d $1=$2 && alias $1="nocorrect $1"; }

hashdir src ~/src
hashdir vnd ~src/vendor
hashdir js ~src/acst/joshs
hashdir legolab ~src/ACS/Lego/_lab

hashdir gps $GOPATH/src
hashdir ggh $GOPATH/src/github.com
hashdir pg $GOPATH/src/p.go

hashdir acst ~/src/github/acst
hashdir golab ~/src/github/joshua/golab

hashdir corp /Volumes/ACS/Corporate
hashdir xfer /Volumes/ACS/Corporate/Transfer\ Location
