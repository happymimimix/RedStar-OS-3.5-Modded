#!/bin/bash

source '/root/Desktop/v3.5 Update Combo/scripts/pkgutils.sh'
trap 'error' ERR
set +e

set -x
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib/:/lib
echo "export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig" >> /etc/bashrc
echo "export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib/:/lib" >> /etc/bashrc
cd /workspace
InstallDef gmp-4.3.2 bz2
InstallDef mpfr-2.4.2 bz2
InstallDef mpc-0.8.1 gz
InstallDef isl-0.14 bz2
Extract nettle-3.4.1 gz
./configure --enable-mini-gmp --prefix=/usr
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l)
make install
CleanUp nettle-3.4.1
Install libtasn1-4.10 gz
Install libunistring-1.1 gz
Extract openssl-1.0.2u gz
./config
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l)
make install
CleanUp openssl-1.0.2u
Install unbound-release-1.8.3 gz
Install libffi-3.3 gz
InstallDef p11-kit-0.23.18.1 gz
mkdir -p /etc/unbound || true
unbound-anchor -a "/etc/unbound/root.key" || true
InstallDef gnutls-3.3.30 xz
Install wget-1.19.5 gz
InstallDef binutils-2.32 xz
Install m4-1.4.18 xz
Install gmp-6.2.1 bz2
Install mpfr-4.1.0 bz2
Install mpc-1.2.1 gz
Install libtool-2.4.6 xz
Install gcc-6.5.0 xz
Install autoconf-2.69 xz
Install make-4.2 bz2
Install bison-3.5.4 xz
Install gawk-4.2.1 xz
Install Python-3.7.6 xz
Install sed-4.4 xz
echo "[Desktop Entry]" > '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Encoding=UTF-8" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Type=Application" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Exec=konsole -e bash -c \"cd /root/Desktop/v3.5\ Update\ Combo;  ./scripts/3.sh\"" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Terminal=false" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Name=v3.5 Update Combo" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Categories=Applocation" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
set +x
trap '' ERR
for ((i = 5; i > 0; i--)); do
    echo -ne "Press any key in $i to abort automatic reboot... \r"
    read -rs -n 1 -t 1 key
    if [[ $key ]]; then
        echo -e "\nReboot aborted. "
        sleep 1
        exec bash
    fi
done
echo -e "\nRebooting now... "
sleep 1
reboot