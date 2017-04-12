# Create a simple Raspberry Pi Kiosk Screen by using one quick Script:
## Features:
- Kioskmode (e.g. for a museum)
- Raspberry Pi with reduced OS (Removed unused Packages)
- SSH Remote Terminal Control (e.g. PuTTy.exe)
- Only Webbrowser as graphical Interface  (Default Page: www.google.com)
- Webserver can deliver Content
- Networkconnection via Ethernet
- Display: Screen/Projector over HDMI
- Control: Mouse/Touch
- Maintenance over SSH Remote Control
## Installation
- Download Raspbian Jessie Lite Image (WITHOUT Pixel): https://www.raspberrypi.org/downloads/raspbian/ <br />
(Tested with Jessie Lite 11.25.2016)
- Save the Image onto a SD Card, plug it into your Raspberry Pi and complete the OS Setup
- Login with Username: pi and Password: raspberry
- Download 'RaspberryPI_Kiosk_Install_Script.sh' from this repository direct to Raspberry or to the root directory of a USB
- Open Raspberry Terminal and type 'ifconfig'
- Note the IPv4 Adress for later SSH Access with PuTTy.exe
- optional: Remove black Borders on 1080p HDMI Screen)<br />
(sudo nano /boot/config.txt)<br />
(Delete '#' Comment before 'disable_overscan=1')<br />
- sudo reboot now
### Set a different default Content page
- Open RaspberryPI_Kiosk_Install_Script.sh
```
sudo nano RaspberryPI_Kiosk_Install_Script.sh
```
- Change Hyperlink in Line 26 to the desired Location
```
echo "#kweb -KAJBHq http://www.google.com"  >> /etc/X11/openbox/autostart
```
## Installation from USB: 
Open Terminal and type 'lsblk' to list all devices and check your USB type (e.g. sda1)
```
sudo mkdir /mnt/usb
sudo mount /dev/sda1 /mnt/usb       (change sda1 if you got another type)
cp /mnt/usb/RaspberryPI_Kiosk_Install_Script.sh /home/pi/RaspberryPI_Kiosk_Install_Script.sh      
(Script File has to be in USB's root directory)
```
Make Script File executeable and run it as admin
```
sudo chmod +x RaspberryPI_Kiosk_Install_Script.sh
sudo ./RaspberryPI_Kiosk_Install_Script.sh
```
## Installation from Raspberry SD Card: 
```
cd [LOCATION OF SCRIPT]
sudo chmod +x RaspberryPI_Kiosk_Install_Script.sh
sudo ./RaspberryPI_Kiosk_Install_Script.sh
```
### Useful Commands:
- List all Packages with a short description:   **dpkg -l**
- Full package description:   **dpkg-query --show --showformat '${Description}\n' [PAKETNAME]**
- List all USB Devices:   **lsblk**
- Deinstall Package:   **apt-get remove -y [PAKETNAME]**
- Remove unused Package-Dependencies:   **apt-get autoremove -y**
- Write Lines into existing Files:   **echo "Inhalt" >> pfad/datei**
- Remove left Configfiles from deleted Packages:   **dpkg --list | grep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge**
### Web:
- https://www.x.org/wiki/
- https://wiki.archlinux.org/index.php/xorg
- https://wiki.archlinux.org/index.php/Openbox
- http://steinerdatenbank.de/software/kweb_manual.pdf
- https://pi-buch.info/raspbian-lite-fuer-den-read-only-betrieb-konfigurieren/
