#!/bin/bash
error() {
set +x
rm -f '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
kdialog --title "Failed To Install v3.5 Update Combo" --error "An unexpected critical error has occured during the installation. \nPlease copy the console output and send them to the development team of Red Star OS 3.5 on discord. \nDiscord server invite link: discord.gg/MY68R2Quq5\n\nWe apologize for the inconvenience. \nThe installation script will now stop. "
bash
exit
}
preperr() {
set +x
kdialog --title "Failed To Install v3.5 Update Combo" --error "Failed to install necessary development tools via 'yum groupinstall'. \nPlease make sure Red Star OS 3.5 installation image is inserted into the device and the built-in yum repo on the image can be accessed normally. \nIf you've already installed all components under the development category and do not need to repeat this process, just ignore this message. \n\nWe apologize for the disruption. \nClick 'OK' to continue... "
}
Install() {
set -x
trap 'error' ERR
set +e
cd /workspace
Extract $1 $2
mkdir W0RK
cd W0RK
local og1=$1
shift 2
../configure --prefix=/usr $@
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l)
make install
cd /workspace
CleanUp $og1
return
}
Extract() {
set -x
trap 'error' ERR
set +e
tar xvf /root/Desktop/v3.5\ Update\ Combo/packages/$1.tar.$2
cd $1
return
}
CleanUp() {
set -x
trap 'error' ERR
set +e
cd /workspace
rm -rf $1
return
}
KernelInstall() {
set -x
trap 'error' ERR
set +e
cd /usr/src/kernels
Extract linux-$1 $2
make allyesconfig
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l)
make modules_install
make install || true
make headers_install INSTALL_HDR_PATH=/usr
sed -i 's/^default=[0-9]\+/default=0/' '/boot/grub/grub.conf'
cd /workspace
return
}