#!/usr/bin/env bash

apt-get update
apt-get -y upgrade
apt-get -y -f install git g++ libssl-dev libncurses5-dev bc m4 make unzip libmnl-dev libssh-dev bison cmake automake autoconf build-essential libpq-dev
apt-get -y -f install curl wget libtool python python-pip cpio bzip2 gcc python3-ply ncurses-dev python-yaml python2

# packages not recommended by nerves-sdk that seem to be required
apt-get install -y zip unzip make

su vagrant <<'EOF'
  mkdir -p /home/vagrant/.nerves-cache
  git clone https://github.com/nerves-project/nerves-sdk.git /home/vagrant/nerves-sdk
  cd /home/vagrant/nerves-sdk
  make nerves_rpi_defconfig
  make
EOF

