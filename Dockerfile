######
FROM ubuntu:16.04
MAINTAINER sppsorrg@gmail.com


RUN 	echo  'mysql-server mysql-server/root_password password lxr' | debconf-set-selections && \
	echo  'mysql-server mysql-server/root_password_again password lxr' | debconf-set-selections

RUN apt-get update && \
	apt-get install -y perl &&\
	apt-get install -y git &&\
	apt-get install -y exuberant-ctags &&\
    apt-get install -y mysql-server &&\
    apt-get install -y apache2 &&\
	apt-get install -y libapache2-mod-perl2 &&\
	apt-get install -y libmysqlclient-dev &&\
	apt-get install -y gcc &&\
	apt-get install -y make &&\
	apt-get install -y flex &&\
	apt-get install -y expect &&\
	cpan DBI &&\
	cpan File::MMagic &&\
	cpan DBD::mysql 

WORKDIR /glimpse
RUN git clone https://github.com/gvelez17/glimpse &&\
cd glimpse &&\
./configure &&\
make &&\
make install

WORKDIR /
RUN apt-get install -y curl &&\
	curl -L https://sourceforge.net/projects/lxr/files/stable/lxr-2.2.1.tgz > lxr.tgz &&\
	tar -xvf lxr.tgz &&\
	mv lxr-2.2.1 lxr

WORKDIR /lxr
ADD custom.d /lxr/custom.d
ADD expect_initdb /lxr
#RUN service mysql start &&\
#./custom.d/initdb.sh &&\
#cp ./custom.d/lxr.conf . &&\
#mkdir /lxr/glimpse_db/lxr/master && \
#cp custom.d/apache-lxrserver.conf  /etc/apache2/conf-available &&\
#a2enconf apache-lxrserver.conf && \
#service apaceh2 start
