set -e
ip addr flush dev wlan0

run_hostapd() {
	/sbin/hostapd /etc/hostapd/hostapd.conf
}

( run_hostapd || touch /tmp/hostapd.failed ) &
sleep 2
if [ -e /tmp/hostapd.failed ]; then
	rm /tmp/hostapd.failed
	( run_hostapd || touch /tmp/hostapd.failed ) &
	sleep 2
	if [ -e /tmp/hostapd.failed ]; then
		rm /tmp/hostapd.failed
		echo "Unable to start hostapd after 2 attempts" >&2
		exit 1
	fi
fi

ip addr add 10.209.89.1/24 dev wlan0

/sbin/dnsmasq -dq
