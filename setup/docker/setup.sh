#! /bin/bash

# Elements from the script are borrowed from z
# https://github.com/bztsrc/raspi3-tutorial/blob/master/00_crosscompiler/README.md

set -e

echo "This script will build and install a cross-compiler onto your system.\n"

# Creating directories
dl_dir=`mktemp -d -t dl_dir.XXXXXX`
mkdir -p "${dl_dir}"
cd "${dl_dir}"
mkdir -p /usr/local/cross-compiler

echo -n "Downloading source tarballs..."
wget https://ftpmirror.gnu.org/binutils/binutils-2.30.tar.gz > /dev/null 2>&1 || true
wget https://ftpmirror.gnu.org/gcc/gcc-8.1.0/gcc-8.1.0.tar.gz > /dev/null 2>&1 || true
wget https://ftpmirror.gnu.org/mpfr/mpfr-4.0.1.tar.gz > /dev/null 2>&1 || true
wget https://ftpmirror.gnu.org/gmp/gmp-6.1.2.tar.bz2 > /dev/null 2>&1 || true
wget https://ftpmirror.gnu.org/mpc/mpc-1.1.0.tar.gz > /dev/null 2>&1 || true
wget https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.18.tar.bz2 > /dev/null 2>&1 || true
wget https://gcc.gnu.org/pub/gcc/infrastructure/cloog-0.18.1.tar.gz > /dev/null 2>&1 || true
echo "done!"

echo -n "Extract the tarballs..."
for i in *.tar.gz; do tar -xzf $i > /dev/null 2>&1 || true; done
for i in *.tar.bz2; do tar -xjf $i > /dev/null 2>&1 || true; done
rm -f *.tar.* > /dev/null 2>&1 || true
echo "done!"

echo "Building the source files..."
cd binutils-*
ln -s ../isl-* isl
cd ..
cd gcc-*
ln -s ../isl-* isl
ln -s ../mpfr-* mpfr
ln -s ../gmp-* gmp
ln -s ../mpc-* mpc
ln -s ../cloog-* cloog
cd ..
mkdir aarch64-binutils
cd aarch64-binutils
../binutils-*/configure --prefix=/usr/local/cross-compiler --target=aarch64-elf \
--enable-shared --enable-threads=posix --enable-libmpx --with-system-zlib --with-isl --enable-__cxa_atexit \
--disable-libunwind-exceptions --enable-clocale=gnu --disable-libstdcxx-pch --disable-libssp --enable-plugin \
--disable-linker-build-id --enable-lto --enable-install-libiberty --with-linker-hash-style=gnu --with-gnu-ld\
--enable-gnu-indirect-function --disable-multilib --disable-werror --enable-checking=release --enable-default-pie \
--enable-default-ssp --enable-gnu-unique-object
make -j4
make install
cd ..
mkdir aarch64-gcc
cd aarch64-gcc
../gcc-*/configure --prefix=/usr/local/cross-compiler --target=aarch64-elf --enable-languages=c \
--enable-shared --enable-threads=posix --enable-libmpx --with-system-zlib --with-isl --enable-__cxa_atexit \
--disable-libunwind-exceptions --enable-clocale=gnu --disable-libstdcxx-pch --disable-libssp --enable-plugin \
--disable-linker-build-id --enable-lto --enable-install-libiberty --with-linker-hash-style=gnu --with-gnu-ld\
--enable-gnu-indirect-function --disable-multilib --disable-werror --enable-checking=release --enable-default-pie \
--enable-default-ssp --enable-gnu-unique-object
make -j4 all-gcc
make install-gcc
cd ..
echo "Installation successful!"
exit 0