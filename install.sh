#!/bin/bash -e

set -x
#Install Dependencies
# multiline command
#sudo apt -y install jackd2 virtualenv git build-essential libasound2-dev libjack-jackd2-dev liblilv-dev libjpeg-dev zlib1g-dev cmake debhelper dh-autoreconf dh-python gperf intltool ladspa-sdk libarmadillo-dev libasound2-dev libavahi-gobject-dev libavcodec-dev libavutil-dev libbluetooth-dev libboost-dev libeigen3-dev libfftw3-dev libglib2.0-dev libglibmm-2.4-dev libgtk2.0-dev libgtkmm-2.4-dev libjack-jackd2-dev libjack-jackd2-dev liblilv-dev liblrdf0-dev libsamplerate0-dev libsigc++-2.0-dev libsndfile1-dev libsndfile1-dev libzita-convolver-dev libzita-resampler-dev lv2-dev p7zip-full python3-pip python3-dev libreadline-dev zita-alsa-pcmi-utils hostapd dnsmasq iptables python3-smbus python3-dev liblo-dev libzita-alsa-pcmi-dev
#
##Install Python Dependencies
## sudo pip3 install pycrypto pyserial==3.0 pystache==0.5.4 aggdraw==1.3.11 scandir backports.shutil-get-terminal-size pycrypto tornado==4.3 Pillow==8.4.0 cython --break-system-packages
#
##Install Mod Software
#mkdir /home/carlo/.lv2
#mkdir /home/carlo/data
#mkdir /home/carlo/data/.pedalboards
#mkdir /home/carlo/data/user-files
#cd /home/carlo/data/user-files
#mkdir "Speaker Cabinets IRs"
#mkdir "Reverb IRs"
#mkdir "Audio Loops"
#mkdir "Audio Recordings"
#mkdir "Audio Samples"
#mkdir "Audio Tracks"
#mkdir "MIDI Clips"
#mkdir "MIDI Songs"
#mkdir "Hydrogen Drumkits"
#mkdir "SF2 Instruments"
#mkdir "SFZ Instruments"
#
## #jackd2
#pushd $(mktemp -d) && git clone https://github.com/jackaudio/jack2.git
#pushd jack2
#./waf configure --prefix=/usr
#./waf build
#sudo ./waf install PREFIX=/usr
#
##Browsepy
#pip install browsepy --break-system-packages
#
#
##Mod-host
#pushd $(mktemp -d) && git clone https://github.com/mod-audio/mod-host.git
#pushd mod-host
#make -j 4
#sudo make install

#Mod-ui
cd ~
python3 -m venv modenv
pushd $HOME && git clone  https://github.com/mod-audio/mod-ui.git
pushd mod-ui
source /home/carlo/modenv/bin/activate
pip install -r requirements.txt
make -C utils
python setup.py install
# exit virtualenv 
deactivate

#Hylia - required for LINK sync
pushd $(mktemp -d) && git clone https://github.com/CarloCattano/Hylia-pi4.git
pushd Hylia-pi4
make -j4
sudo make install PREFIX=/usr


cd /home/carlo/mod-PiSound

#Create Services
sudo cp *.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable browsepy.service 
sudo systemctl enable jack.service
sudo systemctl enable mod-host.service 
sudo systemctl enable mod-ui.service

sudo gpasswd -a $USER audio # add user to audio group


echo "setting up audio group settings"
echo "@audio - rtprio 99" | sudo tee -a /etc/security/limits.conf
echo "@audio - memlock unlimited" | sudo tee -a /etc/security/limits.conf

echo "creating /etc/environment and setting jack promiscuous mode"
echo 'JACK_PROMISCUOUS_SERVER=jack' | sudo tee -a /etc/environment

echo "cleaning tmp folder"
sudo rm -rf /tmp/*

echo "starting mod"
./startMod.sh
