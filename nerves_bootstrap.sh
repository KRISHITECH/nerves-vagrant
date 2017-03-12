#!/usr/local/env bash -x --login vagrant

whoami; sleep 30secs; continue
  
# housekeeping & requirements
sudo apt update
sudo apt -y full-upgrade
sudo apt-get -y -f install git g++ libssl-dev libncurses5-dev bc m4 make unzip libmnl-dev libssh-dev bison cmake automake autoconf build-essential libpq-dev
sudo apt-get -y -f install curl wget libtool python python-pip cpio bzip2 gcc python3-ply ncurses-dev python-yaml
sudo apt-get -y -f install openssl fop xsltproc unixodbc-dev
sudo apt-get -y -f install arduino gcc-avr avr-libc avrdude
sudo apt-get -y -f install python-configobj python-jinja2 python-serial 
sudo apt-get -y -f install default-jdk linux-headers-"$(uname -r)"

#update apt sources
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
wget --quiet -O - http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" | sudo tee -a /etc/apt/sources.list
echo "deb http://packages.erlang-solutions.com/ubuntu trusty contrib" | sudo tee -a /etc/apt/sources.list
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -


#install rvm
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm

#install ruby and set as default
rvm install ruby-2.4.0 --default --binary

#install asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.2.1
echo -e "\n. $HOME/.asdf/asdf.sh" >> ~/.bashrc
echo -e "\n. $HOME/.asdf/completions/asdf.bash" >> ~/.bashrc
source "$HOME/.asdf/asdf.sh"
source "$HOME/.asdf/completions/asdf.bash"


#housekeeping
sudo apt-get update
sudo apt-get -y update
sudo apt-get -y autoremove
sudo apt-get build-dep nodejs erlang

#add asdf node, psql, erlang & elixir
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git && bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
asdf plugin-add postgres https://github.com/smashedtoatoms/asdf-postgres.git

#update asdf plugins
asdf plugin-update --all

#install node
asdf list-all nodejs 
echo "Which one do you want?" 
read -rs -p "nodeversion:" < /dev/tty
asdf install nodejs "$nodeversion" 
asdf global nodejs "$nodeversion"


#install erlang
asdf list-all erlang
echo "Which one do you want?" 
read -rs -p "erlangversion:" < /dev/tty 
asdf install erlang "$erlangversion" 
asdf global erlang "$erlangversion"


#install elixir
asdf list-all elixir 
echo "Which one do you want?"
read -p "elixirversion:" < /dev/tty
asdf install elixir "$elixirversion" 
asdf global elixir "$elixirversion"

#install postgres
asdf list-all postgres 
echo "Which one do you want?" 
read -rs -p "postgresversion:" < /dev/tty 
asdf install postgres "$postgresversion" 
asdf global postgres "$postgresversion"

#start postgres server
pg_ctl start
