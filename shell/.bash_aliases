alias l="ls -lh"
alias ll="ls -lah"

alias my_bat="echo 'Battery:' && upower -i $(upower -e | grep 'BAT') | grep -E 'state|energy:|energy-rate|voltage|time\ to|percentage'"
alias my_temp="sensors coretemp-isa-0000 thinkpad-isa-0000 BAT0-acpi-0 pch_cannonlake-virtual-0 nvme-pci-3d00 acpitz-acpi-0 iwlwifi_1-virtual-0 | grep -vE 'thinkpad-isa-0000|coretemp-isa-0000|temp3|temp4|temp6|temp7|temp8|^$'"
alias my_stat="my_temp && my_bat"
alias my_stat_w="watch -n 2 \"sensors coretemp-isa-0000 thinkpad-isa-0000 BAT0-acpi-0 pch_cannonlake-virtual-0 nvme-pci-3d00 acpitz-acpi-0 iwlwifi_1-virtual-0 | grep -vE 'thinkpad-isa-0000|coretemp-isa-0000|temp3|temp4|temp6|temp7|temp8|^$' && echo 'Battery:' && upower -i $(upower -e | grep 'BAT') | grep -E 'state|energy:|energy-rate|voltage|time\ to|percentage'\""

alias dfh="df -h | grep -v '/dev/loop' | grep -v 'tmpfs'"