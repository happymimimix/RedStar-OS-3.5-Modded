#!/bin/bash
error() {
set +x
rm -f '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
kdialog --title "Failed To Install v3.5 Update Combo" --error "An error has occured during the installation. \nThis could be caused by incomplete installation of the development tools and libraries. Please make sure you've installed ALL packages under Development/Development tools and Development/Development libraries catagory using /Applications/Software Manager.app. \n\nThe installation script will now stop. "
}
Install() {
set -x
trap 'error' ERR
set +e
Extract $1 $2
local og1=$1
shift 2
./configure --prefix=/usr $@
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l)
make install
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
cd ..
rm -rf $1
return
}
KernelInstall() {
set -x
trap 'error' ERR
set +e
cd /usr/src/kernels
Extract linux-$1 $2
yes '' | make oldconfig
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l)
make modules_install
make install || true
make headers_install INSTALL_HDR_PATH=/usr
sed -i 's/^default=[0-9]\+/default=0/' '/boot/grub/grub.conf'
cd /workspace
return
}