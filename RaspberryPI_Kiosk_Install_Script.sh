#!/bin/bash 
#Tested with Raspbian Jessie Lite Version (11.25.2016)
#More Info: https://github.com/smueller92/raspberrypi-kiosk-mode

#Disable Autologin
echo "[Service]" >> /etc/systemd/system/getty@tty1.service.d/autologin.conf 
echo "ExecStart=" >> /etc/systemd/system/getty@tty1.service.d/autologin.conf 
echo "ExecStart=-/sbin/agetty --autologin pi --noclear %I 38400 linux" >> /etc/systemd/system/getty@tty1.service.d/autologin.conf 

#Update packages
apt-get update 

#Install Windowmanager Openbox, xterm, Xorg, lightdm
apt-get install -y xserver-xorg-core xserver-xorg xserver-xorg-input-mouse xserver-xorg-input-evdev xserver-xorg-video-fbdev lightdm openbox xterm

#Install KWeb Browser
cd ~
wget http://steinerdatenbank.de/software/kweb-1.6.9.tar.gz 
tar -xzf kweb-1.6.9.tar.gz 
cd kweb-1.6.9 
./debinstall 
cd ~

#>>>>>>>>>>>>>>>>>>>>>>>>>CHANGE THIS LINE FOR A DIFFERENT CONTENT PAGE<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
#Add kweb Browser (Kiosk-Mode) to Openbox Autostart and set www.google.com as default Contentpage
echo "#kweb -KAJBHq http://www.google.com"  >> /etc/X11/openbox/autostart

#Deinstall unused packages (optional to minimize OS size)
apt-get remove -y aptitude aptitude-common bluez bluez-firmware cifs-utils crda bzip2 dpkg-dev gdb info		#25MB
apt-get remove -y console-setup console-setup-linux fakeroot firmware-brcm80211  firmware-atheros firmware-libertas firmware-ralink firmware-realtek #14MB
apt-get remove -y libalgorithm-c3-perl libarchive-extract-perl #884KB
apt-get remove -y libboost-iostreams1.49.0 libboost-iostreams1.50.0 libcurl3:armhf libcwidget3 libevent-2.0-5:armhf #2854KB
apt-get remove -y libgomp1:armhf libiw30:armhf libldap-2.4-2:armhf libmagic1:armhf  #64MB
apt-get remove -y libnl-3-200:armhf libpcsclite1:armhf libxapian22 rsyslog		#6,27MB
apt-get remove -y vim-common whois tasksel tasksel-data python-apt-common python3 python3-minimal python3.4 python3.4-minimal #10,3MB
apt-get remove -y fake-hwclock dosfstools ed libraspberrypi-doc gnome-icon-theme aspell xfonts-utils

#Delete left package-dependencies and config-files from deinstalled packages
apt-get autoremove -y
dpkg --list |grep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge 

#Push Start-Script into Autostart
#Delete the last Line ('exit 0'), add 'ssh start', disable Screensaver/Powersave and add the last Line ('exit 0') again
tail -n 1 "/etc/rc.local" | wc -c | xargs -I {} truncate "/etc/rc.local" -s -{}
echo "/etc/init.d/ssh start" >> /etc/rc.local
echo "setterm -blank 0 -powersafe off" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local

#Reboot into Kiosk Mode
reboot now
