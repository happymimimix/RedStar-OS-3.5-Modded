#!/bin/bash
kdialog --title "Install v3.5 Update Combo" --error "This tool will guide you through the installation process of the unofficial v3.5 update for Red Star OS 3.0. \n\nThis will upgrade the system kernel to 5.4 x86_64 along with updates to many other critical system components and libraries including but not limited to gcc and yum. \n\nThe process is fully automatic, do not touch anything except typing your login password when asked. \nYour device will reboot for a couple of times during the process, it's recommended to set up automatic login in \"System Preferences -> Accounts -> Login Options -> Automatic Login\" so the amount of times the password need to be typed can be decreased. \n\nClick 'OK' when ready... "
set -x
source '/root/Desktop/v3.5 Update Combo/scripts/pkgutils.sh'
trap 'error' ERR
set +e
# export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig
# export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib/:/lib
# echo "export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig" >> /etc/bashrc
# echo "export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib/:/lib" >> /etc/bashrc
rm -rf /workspace
mkdir /workspace
cd /workspace
trap 'preperr' ERR
yum groupinstall "Develop Editors" "Development Tools" "Development Libraries" -y
trap 'error' ERR
Install bc-1.07.1 gz --enable-shared
Install make-4.2.1 gz --with-libintl-prefix --with-libiconv-prefix --with-gnu-ld
Install gmp-4.3.2 bz2 --enable-cxx --enable-shared
Install mpfr-2.4.2 bz2 --enable-shared
Install mpc-0.8.1 gz --enable-shared
Install isl-0.14 bz2
Install gcc-6.5.0 xz --mandir=/usr/share/man --infodir=/usr/share/info --enable-bootstrap --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --with-tune=generic --enable-languages=ada,c,c++,fortran,go,java,jit,lto,objc,obj-c++ --enable-shared --enable-multilib --enable-host-shared
Install ncurses-5.6 gz
Install gmp-6.2.1 bz2 --enable-cxx --enable-shared
Install mpfr-4.1.0 bz2 --enable-shared
Install mpc-1.2.1 gz --enable-shared
Install isl-0.24 bz2
Install nettle-3.4.1 gz --enable-shared --enable-threads
Install libtasn1-4.10 gz
Install libunistring-1.1 gz
cd /workspace
Extract openssl-1.0.2u gz
./config --openssldir=/usr/ssl
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l)
make install
CleanUp openssl-1.0.2u
Install unbound-release-1.8.3 gz
Install libffi-3.3 gz
Install p11-kit-0.23.18.1 gz
mkdir -p /etc/unbound || true
unbound-anchor -a "/etc/unbound/root.key" || true
Install gnutls-3.3.30 xz --enable-shared --enable-plugins
Install wget-1.19.5 gz
Install m4-1.4.18 xz
Install libtool-2.4.6 xz --enable-shared
Install autoconf-2.69 xz
Install bison-3.5.4 xz 
Install gawk-4.2.1 xz
Install sed-4.4 xz
Install Python-3.7.6 xz --enable-optimizations --with-pydebug
Install gdb-7.12 xz
Install help2man-1.47.17 xz
Install crosstool-ng-1.23.0 xz
mkdir /workspace/CTNG
cp /root/Desktop/v3.5\ Update\ Combo/packages/CTNG_CFG /workspace/CTNG/.config -fd
mkdir /workspace/CTNG/src
cp /root/Desktop/v3.5\ Update\ Combo/packages/linux-3.19.8.tar.gz /workspace/CTNG/src/linux-3.16.42.tar.gz -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/make-4.2.1.tar.gz /workspace/CTNG/src/make-4.2.1.tar.gz -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/gcc-6.3.0.tar.bz2 /workspace/CTNG/src/gcc-6.3.0.tar.bz2 -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/glibc-2.25.tar.xz /workspace/CTNG/src/glibc-2.25.tar.xz -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/ecj-latest.jar /workspace/CTNG/src/ecj-latest.jar -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/m4-1.4.18.tar.xz /workspace/CTNG/src/m4-1.4.18.tar.xz -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/autoconf-2.69.tar.xz /workspace/CTNG/src/autoconf-2.69.tar.xz -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/automake-1.15.tar.xz /workspace/CTNG/src/automake-1.15.tar.xz -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/libtool-2.4.6.tar.xz /workspace/CTNG/src/libtool-2.4.6.tar.xz -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/zlib-1.2.11.tar.xz /workspace/CTNG/src/zlib-1.2.11.tar.xz -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/gmp-6.2.1.tar.bz2 /workspace/CTNG/src/gmp-6.1.2.tar.bz2 -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/mpfr-4.1.0.tar.bz2 /workspace/CTNG/src/mpfr-3.1.5.tar.bz2 -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/isl-0.14.tar.bz2 /workspace/CTNG/src/isl-0.18.tar.bz2 -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/mpc-1.2.1.tar.gz /workspace/CTNG/src/mpc-1.0.3.tar.gz -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/binutils-2.27.tar.bz2 /workspace/CTNG/src/binutils-2.27.tar.bz2 -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/expat-2.2.0.tar.bz2 /workspace/CTNG/src/expat-2.2.0.tar.bz2 -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/ncurses-6.0.tar.gz /workspace/CTNG/src/ncurses-6.0.tar.gz -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/libiconv-1.15.tar.gz /workspace/CTNG/src/libiconv-1.15.tar.gz -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/gettext-0.19.8.1.tar.xz /workspace/CTNG/src/gettext-0.19.8.1.tar.xz -fd
cp /root/Desktop/v3.5\ Update\ Combo/packages/gdb-7.12.tar.xz /workspace/CTNG/src/gdb-7.12.1.tar.xz -fd
OGLIB=$LD_LIBRARY_PATH
unset LD_LIBRARY_PATH
cd /workspace/CTNG
ct-ng build
PATH=~/x-tools/x86_64-unknown-linux-gnu/bin:$PATH
CROSS_COMPILE=x86_64-unknown-linux-gnu-
ARCH=x86_64
KernelInstall 3.19.8 gz
echo "[Desktop Entry]" > '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Encoding=UTF-8" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Type=Application" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
echo "Exec=konsole -e bash -c \"cd /root/Desktop/v3.5\ Update\ Combo;  ./scripts/2.sh\"" >> '/root/Desktop/v3.5 Update Combo/scripts/next.desktop'
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