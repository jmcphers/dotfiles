#!/usr/bin/env bash

# download and extract sources
cd /tmp
wget https://ftp.gnu.org/pub/gnu/global/global-6.6.tar.gz
tar xzvf global-6.6.tar.gz

# compile
cd global-6.6
./configure --prefix=/usr/local
make
sudo make install prefix=/usr/local/stow/global-6.6

# invoke stow to symlink binaries
sudo stow global-6.6 

