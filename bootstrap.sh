#!/usr/bin/env bash

# ruby, java, git, curl and couchdb
apt-get update
apt-get install unzip ruby default-jre-headless curl git couchdb libgd2-noxpm tmux vim libxslt-dev libxml2-dev ruby1.9.1-dev -y

# startup
#sed -i -e 's/exit/#exit/g' /etc/rc.local
echo SUBSYSTEM=="bdi",ACTION=="add",RUN+="/root/neo4j/bin/neo4j start" > /etc/udev/rules.d/40-neo4j.rules
echo SUBSYSTEM=="bdi",ACTION=="add",RUN+="su vagrant -c 'cd /vagrant && nohup rackup &'" > /etc/udev/rules.d/50-vagrant.rules

# config ruby gems to https
gem sources -r http://rubygems.org
gem sources -r http://rubygems.org/
gem sources -a https://rubygems.org
gem install bundler

# add rbenv
su vagrant -c "git clone https://github.com/sstephenson/rbenv.git ~/.rbenv"
su vagrant -c "echo 'export PATH=\"$HOME/.rbenv/bin:$PATH\"' >> ~/.bash_profile"
su vagrant -c "echo 'eval \"$(rbenv init -)\"' >> ~/.bash_profile"
su vagrant -c "git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build"

# initial config of app
cd /vagrant
bundle install

# neo4j
cd /root
wget http://dist.neo4j.org/neo4j-community-2.0.1-unix.tar.gz?jpg -O neo4j.tar.gz
tar -xvf neo4j.tar.gz
rm neo4j.tar.gz
mv neo4j* neo4j
wget http://dist.neo4j.org/spatial/neo4j-spatial-0.12-neo4j-2.0.0-server-plugin.zip?jpg -O neo4j-spatial.zip
unzip neo4j-spatial.zip -d neo4j/plugins
rm neo4j-spatial.zip
sed -i -e 's/#org.neo4j.server.webserver.address=0.0.0.0/org.neo4j.server.webserver.address=0.0.0.0/' neo4j/conf/neo4j-server.properties
neo4j/bin/neo4j start

echo "Done bootstraping"

