#!/usr/bin/env bash

set -x

su -- vagrant

# housekeeping & requirements
sudo apt update
sudo apt -y full-upgrade
sudo apt -y autoremove

# install time
sudo apt-get -y -f install git g++ libssl-dev libncurses5-dev bc m4 make \
                           unzip libmnl-dev libssh-dev bison cmake automake \
                           autoconf build-essential libpq-dev libffi-dev clang

sudo apt-get -y -f install curl wget libtool python python-pip cpio bzip2 gcc \
                           python3-ply ncurses-dev python-yaml graphviz python-apt

sudo apt-get -y -f install openssl fop xsltproc unixodbc-dev python3-apt

sudo apt-get -y -f install arduino gcc-avr avr-libc avrdude arduino-core arduino-mk

sudo apt-get -y -f install python-configobj python-jinja2 python-serial

sudo apt-get -y -f install default-jdk linux-headers-"$(uname -r)" squashfs-tools ssh-askpass

# update package sources & keys
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
wget --quiet -O - http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" | sudo tee -a /etc/apt/sources.list
echo "deb http://packages.erlang-solutions.com/ubuntu trusty contrib" | sudo tee -a /etc/apt/sources.list
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

# install rvm
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

# install ruby and set as default
rvm install ruby-2.4.0 --default --binary

# install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.2.1
  echo -e "\n. $HOME/.asdf/asdf.sh" >> ~/.bashrc
  echo -e "\n. $HOME/.asdf/completions/asdf.bash" >> ~/.bashrc

# just in case
source ~/.asdf/asdf.sh
source ~/.asdf/completions/asdf.bash


#housekeeping
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y autoremove
#sudo apt-get build-dep nodejs elixir erlang-dev postgresql arduino

#fix sources
git clone https://github.com/davidfoerster/apt-remove-duplicate-source-entries.git
cd ~/apt-remove-duplicate-source-entries
sudo ./apt-remove-duplicate-source-entries.py --help
sleep 10s
sudo ./apt-remove-duplicate-source-entries.py -y && cd ~/
sleep 10s
sudo apt-get update

#add asdf node, psql, erlang & elixir
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git && bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin-add postgres https://github.com/smashedtoatoms/asdf-postgres.git

#update asdf plugins
asdf plugin-update --all

#make global .tool-versions file and install latest versions (comment out to disable this section)
touch ~/.tool-versions
echo -n "nodejs " >> ~/.tool-versions
echo "$(asdf list-all nodejs | sort -nr - | head -1)" >> ~/.tool-versions
echo -n "erlang " >> ~/.tool-versions
echo "$(asdf list-all erlang | sort -nr - | head -1)" >> ~/.tool-versions
echo -n "elixir " >> ~/.tool-versions
echo "$(asdf list-all elixir | sort -nr - | head -1)" >> ~/.tool-versions
echo -n "postgres " >> ~/.tool-versions
echo "$(asdf list-all postgres | sort -nr - | head -1)" >> ~/.tool-versions

#asdf install
asdf install


#install node
#asdf list-all nodejs >> echo command "sort -" | read -r -p "$nodeversion"
#asdf install nodejs "$nodeversion"
#asdf global nodejs "$nodeversion"


#install erlang
#asdf list-all erlang | sort - | read -r -p "$erlangversion"
#asdf install erlang "$erlangversion"
#asdf global erlang "$erlangversion"


#install elixir
#asdf list-all elixir | sort - | read -r -p "$elixirversion"
#asdf install elixir "$elixirversion"
#asdf global elixir "$elixirversion"

#install postgres
#asdf list-all postgres | sort - | read -r -p "$postgresversion"
#asdf install postgres "$postgresversion"
#asdf global postgres "$postgresversion"

sleep 10s

#reboot because why not
sudo reboot now
