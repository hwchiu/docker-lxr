######
FROM ubuntu:16.04
MAINTAINER sppsorrg@gmail.com


RUN 	echo  'mysql-server mysql-server/root_password password your_password' | debconf-set-selections && \
	echo  'mysql-server mysql-server/root_password_again password your_password' | debconf-set-selections

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
	cpan DBI &&\
	cpan File::MMagic &&\
	cpan DBD::mysql 

WORKDIR /glimpse
RUN git clone https://github.com/gvelez17/glimpse &&\
cd glimpse 
./configure &&\
make &&\
make install

#set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
#set termencoding=utf-8
#set encoding=utf-8
