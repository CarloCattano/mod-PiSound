##### [MOD Devices](https://moddevices.com/) software install script for Raspberry OS 64bit with [PiSound hat](https://blokas.io/pisound/) from Blokas Labs
*** 

>_use at your own risk!_ _tested on a fresh install of [Raspberry Pi OS Lite 64bit](https://www.raspberrypi.com/software/operating-systems/)_


update system and install git
```
sudo apt update && sudo apt upgrade -y
sudo apt install git
```
Clone the repository in your ```$HOME``` folder
```
cd ~
git clone https://github.com/CarloCattano/mod-PiSound
cd mod-PiSound/
```
sets your username in scripts and services
```
./setUsername.sh
```
Triggers installation, say yes to the jackd2 promt asking for realtime permissions
```
./install.sh
```

your user will be added to the audio group and assigned rtprio as per [Linux Audio Wiki](https://wiki.linuxaudio.org/wiki/system_configuration) 


This is a modification from the original to work with PiSound hat and some other changes to make it work good on a fresh raspberry pi OS install. 

### Using other soundcards
>+ if you wish to use it with another soundcard (say an 8 ch one for instance :-) just replace the interface name in [this line](https://github.com/CarloCattano/mod-PiSound/blob/180841fd0fb1f49f636e00f46230d9f829b783c4/jack.service#L14) with your interface name instead of ```hw:pisound```

&nbsp; 


The audio settings are in ```jack.service``` where you can change the buffer size(-p), sample rate(-r), periods(-n) etc.

Plugins must be compiled by you either using the [MOD plugin builder](https://github.com/moddevices/mod-plugin-builder)
Check [my gist](https://gist.github.com/CarloCattano/83d572ea18031ca6e40ce8545b6f174c) explaining how to compile plugins for your pi or mod 


The setup allows to use MOD software alongside other programs like sequencers, plugin hosts or other daws and route the audio at will using any jack patching tool


&nbsp; 
&nbsp;  


 >If you want to overclock your pi to 1.8 GHz instead of the >default 1.5 GHz consider using a fan or other means of cooling, things can warm up to 80ºC!
 >You do so by adding ```arm_boost=1``` in your ```/boot/config.txt``` 

&nbsp;


 uninstall.sh is a WIP 
