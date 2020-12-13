FROM archlinux

RUN pacman -Sy --noconfirm hostapd dnsmasq

WORKDIR /etc
COPY dnsmasq.hosts .
COPY dnsmasq.conf .
COPY hostapd.conf hostapd/

WORKDIR /root
COPY start.sh .

CMD /bin/bash start.sh
