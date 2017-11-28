# install xcode command line tools

log::step "Installing Xcode Command Line Tools"

xcode::should_install_tools() {
  dir=$(/usr/bin/xcode-select -print-path 2>/dev/null || true)
  [[ -z "$dir" || ! -f "$dir/usr/bin/git" ]]
}

xcode::check_license() {
  [[ $(/usr/bin/xcrun clang 2>&1) =~ "license" ]] && {
    log::n "Accept Xcode license and press any key to continue:"
    sudo xcodebuild -license
    read -k1 -s
  }
}

xcode::install_tools() {
  log::n "Searching online for the Command Line Tools"

  # this temp file prompts the 'softwareupdate' utility to list the Command
  # Line Tools as an available update
  clt_placeholder="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
  sudo /usr/bin/touch $clt_placeholder

  clt_label=$(softwareupdate -l | \
              grep -B 1 -E "Command Line (Developer|Tools)" | \
              awk -F"*" '/^ +\\*/ {print $2}' | \
              sed 's/^ *//' | \
              tail -n1)

  log::n "Installing $clt_label"
  sudo /usr/sbin/softwareupdate -i $clt_label
  sudo /bin/rm -f $clt_placeholder

  # the headless install may have failed, so failback to the original
  # 'xcode-select' method
  xcode::should_install_tools && {
    log::n "Headless install failed, prompting for install."
    log::n "press any key when the installation has completed:"
    read -k1 -s
  }

  sudo /usr/bin/xcode-select --switch /Library/Developer/CommandLineTools
  xcode::check_license
}

if xcode::should_install_tools; then
  xcode::install_tools
else
  log::g "Xcode Command Line Tools already installed"
fi
