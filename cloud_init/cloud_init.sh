#!/bin/bash
#
# boot-to-dahak-yeti script
# 
# This script is intended to get you from
# bare metal to a machine ready to run
# dahak workflows (including dotfiles, scripts,
# python, snakemake, and singularity.)
#
# Run as a one-shot installer:
# bash <( curl https://raw.githubusercontent.com/dahak-metagenomics/dahak-yeti/master/cloud_init/cloud_init.sh )
set -x

# ubuntu AMI provides this non-root user by default :)
REGUSER="ubuntu"

# first things first
apt-get update
apt-get install -y git

# get copy of yeti for root user
DOTFILES="dotfiles"
git clone https://github.com/dahak-metagenomics/dahak-yeti $DOTFILES

# NOTE: use 169.254.x.y to get AWS name tag

# run root init script
$DOTFILES/tasks_sudo/sudo_init.sh yeti

# copy the user init script
cp $DOTFILES/tasks_user/user_init.sh /home/$REGUSER/.
chown $REGUSER:$REGUSER /home/$REGUSER/user_init.sh

# run user init script as user
sudo -H -i -u $REGUSER /home/$REGUSER/user_init.sh
