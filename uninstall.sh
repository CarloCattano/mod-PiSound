#!/bin/sh

#work in progress 

sudo systemctl disable browsepy.service 
sudo systemctl disable jack.service
sudo systemctl disable mod-host.service 
sudo systemctl disable mod-ui.service

#remove all created services and folders created by install.sh, service files are in /usr/lib/systemd/system
echo "Removing Services"
sudo rm /usr/lib/systemd/system/jack.service
sudo rm /usr/lib/systemd/system/browsepy.service
sudo rm /usr/lib/systemd/system/mod-host.service
sudo rm /usr/lib/systemd/system/mod-ui.service

echo "Removing Folders"
sudo rm /home/carlo/.lv2 -rf
sudo rm /home/carlo/data -rf
sudo rm /home/carlo/mod -rf