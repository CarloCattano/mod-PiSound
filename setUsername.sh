#!/bin/sh

echo "setting username to $USER for install scripts and services"

for f in *; do
    sed -i "s/carlo/$USER/g" $f
done

sudo chmod +x install.sh stopMod.sh startMod.sh uninstall.sh

echo "Making install.sh executable, run ./install.sh to start the installation process"