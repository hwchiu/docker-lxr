#!/bin/sh

if [ $# -lt 2 ]
then
	echo "you must specify the public_ip_address and at least one version name for your source code"
	exit 0
fi

echo $@
public_ip=$1
#replace the public ip address public_ip_address
sed -i.bak s/public_ip_address/$1/g /lxr/lxr.conf
sed -i.bak s/public_ip_address/$1/g /lxr/custom.d/apache-lxrserver.conf

shift 
index=0
while [ $# -gt 0 ]
do
sed -i.bak s/VERSION$index/$1/g /lxr/lxr.conf
mkdir -p /lxr/glimpse_db/lxr/$1
shift
index=$(($index+1))
done

while [ $index -le 9 ]
do
sed -i.bak s/VERSION$index//g /lxr/lxr.conf
index=$(($index+1))
done

service mysql start
expect /lxr/expect_initdb
service apache2 start

cd /lxr
./genxref  --allurls

exec "/bin/bash"
