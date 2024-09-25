#!/bin/bash -e

echo "Mod services status..."
sudo systemctl status jack mod-host mod-ui browsepy
