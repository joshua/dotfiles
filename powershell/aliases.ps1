# Aliases and Functions
#
# TODO: Move to separate modules
#


#
# Sublime Text 2
#
Set-Alias subl 'C:\Program Files\Sublime Text 2\sublime_text.exe'
function st { subl $args }
function stt { subl . $args}


#
# Project shortcuts
#
function cdst { Set-Location \Projects\Stratus }

function cdm { Set-Location Z:\ }
function cdmj { Set-Location Z:\Josh }
function cdmd { Set-Location Z:\Developer }
function cdms { Set-Location Z:\Developer\ACS\Stratus }

#
# Sanity
#
Set-Alias ll Get-ChildItem
Set-Alias open Invoke-Item

function touch { Set-Content -Path ($args[0]) -Value ($null) }


#
# Git Aliases
#
function _git_status { git status -sb }
Set-Alias gst _git_status
Set-Alias gs _git_status

function _git_diff { git diff $args }
Set-Alias gd _git_diff

function _gitk { gitk --all }
Set-Alias gk _gitk

#
# Edit Profile
#
function Edit-Profile { subl $Profile }
Set-Alias ep Edit-Profile


#
# Live Reload Profile
#
# TODO: This doesn't really work.
#
function Reload-Profile {
  @(
    $Profile.AllUsersAllHosts,
    $Profile.AllUsersCurrentHost,
    $Profile.CurrentUserAllHosts,
    $Profile.CurrentUserCurrentHost
  ) | % {
    if(Test-Path $_) {
      Write-Verbose "Running $_"
      . $_
    }
  }
}
Set-Alias reload Reload-Profile


#
# Stop VS web servers
#
function Stop-WebServers { Stop-Process -ProcessName @('WebDev.WebServer*') }
Set-Alias sws Stop-WebServers


#
# Other Helper Functions
#

# Convert decimal to hex
function to-hex([long] $dec) {
  return "0x" + $dec.ToString('X')
}

# Return IPs for all interfaces
function get-ips() {
  $ent = [net.dns]::GetHostEntry([net.dns]::GetHostName())
  return $ent.AddressList | ?{ $_.ScopeId -ne 0 } | %{
    [string]$_
  }
}

# Do a GC run
function run-gc() {
  [void]([System.GC]::Collect())
}

# launch VS dev webserver, from Harry Pierson
# http://devhawk.net/2008/03/20/WebDevWebServer+PowerShell+Function.aspx
function webdev($path,$port=8080,$vpath='/') {
  $spath = "$env:ProgramFiles\Common*\microsoft*\DevServer\9.0\WebDev.WebServer.EXE"

  $spath = resolve-path $spath
  $rpath = resolve-path $path
  &$spath "/path:$rpath" "/port:$port" "/vpath:$vpath"
  "Started WebDev Server for '$path' directory on port $port"
}

# uuidgen.exe replacement
function uuidgen {
  [guid]::NewGuid().toString('d')
}

# Get the syntax of a cmdlet, even if we have no help for it
function get-syntax([string] $cmdlet) {
  get-command $cmdlet -syntax
}

# Get a hash from a string
function convert-tobinhex($array) {
  $str = new-object system.text.stringbuilder
  $array | %{
    [void]$str.Append($_.ToString('x2'))
  }
  return $str.ToString()
}

function convert-frombinhex([string]$binhex) {
  $arr = new-object byte[] ($binhex.Length/2)

  for ( $i=0; $i -lt $arr.Length; $i++ ) {
    $arr[$i] = [Convert]::ToByte($binhex.substring($i*2,2), 16)
  }

  return $arr
}

function get-hash($value, $algorithm = 'SHA256') {
  if ( $value -is [string] ) {
    $value = [text.encoding]::UTF8.GetBytes($value)
  }

  $hash = [security.cryptography.hashalgorithm]::Create($algorithm)

  return convert-tobinhex($hash.ComputeHash($value));
}

function escape-html($text) {
  $text = $text.Replace('&', '&amp;')
  $text = $text.Replace('"', '&quot;')
  $text = $text.Replace('<', '&lt;')
  $text.Replace('>', '&gt;')
}

# ugly, ugly, ugly
function to-binle([long]$val) {
  [Convert]::ToString($val, 2)
}

function byteToChar([byte]$b) {
  if ( $b -lt 32 -or $b  -gt 127 ) {
    '.'
  } else {
    [char]$b
  }
}

function format-bytes($bytes, $bytesPerLine = 8) {
  $buffer = new-object system.text.stringbuilder
  for ( $offset=0; $offset -lt $bytes.Length; $offset += $bytesPerLine ) {
    [void]$buffer.AppendFormat('{0:X8}   ', $offset)
    $numBytes = [math]::min($bytesPerLine, $bytes.Length - $offset)
    for ( $i=0; $i -lt $numBytes; $i++ ) {
       [void]$buffer.AppendFormat('{0:X2} ', $bytes[$offset+$i])
    }
    [void]$buffer.Append(' ' *((($bytesPerLine - $numBytes)*3)+3))
    for ( $i=0; $i -lt $numBytes; $i++ ) {
      [void]$buffer.Append( (byteToChar $bytes[$offset + $i]) )
    }
    [void]$buffer.Append("`n")
  }
  $buffer.ToString()
}

function convertfrom-b64([string] $str) {
  [convert]::FromBase64String($str)
}

function normalize-array($array, [int]$offset, [int]$len=$array.Length-$offset) {
  $dest = new-object $array.GetType() $len
  [array]::Copy($array, $offset, $dest, 0, $len)
  $dest
}

# SID mapping functions
function Resolve-SID($stringSid) {
  $objSID = New-Object System.Security.Principal.SecurityIdentifier($stringSid)
  $objUser = $objSID.Translate([System.Security.Principal.NTAccount])
  $objUser.Value
}

function Resolve-User($user) {
  $objUser = New-Object System.Security.Principal.NTAccount($user)
  $objSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])
  $objSID.Value
}
