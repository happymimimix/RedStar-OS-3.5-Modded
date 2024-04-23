#!/bin/bash

error() {
    set +x
    rm -f '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
    kdialog --title "Failed To Install v3.5 Update Combo" --error "An error has occured during the installation. \nThis could be caused by incomplete installation of the development tools and libraries. Please make sure you've installed ALL packages under Development/Development tools and Development/Development libraries catagory using /Applications/Software Manager.app. \n\nThe installation script will now stop. "
    exec bash
    exit 1
}

Install() {
    trap 'error' ERR
    set +e
    Extract $1 $2
    ./configure --prefix=/usr
    make -j$(cat /proc/cpuinfo | grep "processor" | wc -l)
    make install
    CleanUp $1
    return
}

InstallDef() {
    trap 'error' ERR
    set +e
    Extract $1 $2
    ./configure
    make -j$(cat /proc/cpuinfo | grep "processor" | wc -l)
    make install
    CleanUp $1
    return
}

Extract() {
    trap 'error' ERR
    set +e
    tar xvf /root/Desktop/v3.5\ Update\ Combo/packages/$1.tar.$2
    cd $1
    return
}

CleanUp() {
    trap 'error' ERR
    set +e
    cd ..
    rm -rf $1
    return
}

InstallKernel() {
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