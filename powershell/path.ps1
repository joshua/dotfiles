#
# Local helper to append to the env PATH
#
function script:append-path([string] $path) {
  if ( -not [string]::IsNullOrEmpty($path) ) {
    if ( (test-path $path) -and (-not $env:PATH.contains($path)) ) {
      $env:PATH += ';' + $path
    }
  }
}

#
# Append PATH with useful directories
#
append-path "$DOTFILES\bin"
append-path "C:\Program Files\Sublime Text 2"
append-path "$($env:WINDIR)\system32\inetsrv"
