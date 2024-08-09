#!/bin/bash
set -x
source '/root/Desktop/v3.5 Update Combo/scripts/pkgutils.sh'
trap 'error' ERR
set +e
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib/:/lib
cd /workspace
Install gmp-4.3.2 bz2 --enable-cxx
Install mpfr-2.4.2 bz2
Install mpc-0.8.1 gz
Install isl-0.14 bz2
Install nettle-3.4.1 gz
Install libtasn1-4.10 gz
Install libunistring-1.1 gz
Extract openssl-1.0.2u gz
./config --prefix=/usr --enable-fips --enable-ssl2 --enable-ssl3 --enable-weak-ssl-ciphers --with-zlib
make -j$(cat /proc/cpuinfo | grep "processor" | wc -l)
make install
CleanUp openssl-1.0.2u
Install unbound-release-1.8.3 gz
Install libffi-3.3 gz
Install p11-kit-0.23.18.1 gz
mkdir -p /etc/unbound || true
unbound-anchor -a "/etc/unbound/root.key" || true
Install gnutls-3.3.30 xz --enable-shared
Install wget-1.19.5 gz
Install binutils-2.32 xz --enable-shared
Install m4-1.4.18 xz
Install gmp-6.2.1 bz2 --enable-cxx --enable-shared
Install mpfr-4.1.0 bz2 --enable-shared
Install mpc-1.2.1 gz --enable-shared
Install libtool-2.4.6 xz --enable-shared
Install make-4.2 bz2
Install autoconf-2.69 xz
Install bison-3.5.4 xz 
Install gawk-4.2.1 xz
Install Python-3.7.6 xz --enable-optimizations
Install sed-4.4 xz
Install gcc-6.5.0 xz --enable-languages=c,c++,fortran,go,java,lto,jit,objc,obj-c++ --enable-shared --enable-multilib --enable-libgomp --enable-threads=posix
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