function convert_base { echo "obase=$2; ibase=$1; $3" | bc }

hex2decimal() { convert_base 16 10 $1 }
alias h2d=hex2decimal

hex2binary() { convert_base 16 2 $1 }
alias h2b=hex2binary

decimal2hex() { convert_base 10 16 $1 }
alias d2h=decimal2hex

decimal2binary() { convert_base 10 2 $1 }
alias d2b=decimal2binary

binary2hex() { convert_base 2 16 $1 }
alias b2h=binary2hex

binary2decimal() { convert_base 2 10 $1 }
alias b2d=binary2decimal
