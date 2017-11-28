# check if FileValue full-disk encyption is enabled on the root volumne
# if not, enable it and output the recovery key to the desktop
log::step "Checking Full-disk encryption"

if fdesetup isactive / >/dev/null; then
  log::g "Full-disk encryption enabled on root volume"
else
  sudo fdesetup enable -user "$USER" | tee ~/Desktop/filevault_recovery_key.txt
  log::g "Full-disk encryption enabled on root volume. Please reboot."
  exit 0
fi
