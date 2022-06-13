#!/bin/sh

# Dependencies:
# acpi
# herbe
# ip

# This is supposed to be run by spectrwm

while true;
do
	# fetching section
	bat=$(acpi | awk '{print $4}' | tr -d ',')
	is_charging=$(acpi | awk '{print $3}' | tr -d ',')
	batnum=$(echo $bat | tr -d '%')
	wlan=$(ip add | grep "inet\ .*wlan0" | awk '{print $2}')
	disk_usd=$(df -h | grep root | awk '{print $5}')
	mem_tot=$(free -h | grep Mem | awk '{print $2}')
	mem_usd=$(free -h | grep Mem | awk '{print $3}')

	# populate bar section
	echo "Battery: $bat    Wlan: $wlan    Disk Usage: $disk_usd    Total RAM: $mem_tot    Used RAM: $mem_usd"

	# notification section
	if [ $batnum -le 20 ] && [ $is_charging != "Charging" ]
	then
		herbe "Battery ending: $bat"
	fi

    # useful stuff

    # correct backlight when plugged to energy
    amd="/sys/class/backlight/amdgpu_bl0"
    intel="/sys/class/backlight/intel_backlight"
    if [ -d $amd ] && [ $(cat $amd/brightness) -lt 100 ]; then
        if [ -w $amd/brightness ]; then
            echo "100" > $amd/brightness
        else 
            herbe "$amd/brightness not writable!"
        fi
    elif [ -d $intel ] && [ $(cat $intel/brightness) -lt 4650 ]; then
        if [ -w $intel/brightness ]; then
            echo "4650" > $intel/brightness
        else
            herbe "$intel/brightness not writable!"
        fi
    else
        echo ''
    fi

	sleep 10
done
