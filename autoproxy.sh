#!/bin/bash
count=1
proxy="proxy3.pens.ac.id"
server="google.com"
testuser=`id | awk -F'uid=' '{print $2}' |awk -F'(' '{print $1}'`
#testinet=`ping -c $count $server | grep received | awk -F',' '{print $2}' | awk '{print $1}'`
#testproxy=`ping -c $count $proxy | grep received | awk -F',' '{print $2}' | awk '{print $1}'`
file="/etc/apt/apt.conf.d/proxy"
file2="/etc/apt/apt.conf.d/proxy.disabled"
clear
echo “**************************************”
echo “********* Proxy Auto Config **********”
echo “**************************************”
if [ "$testuser" != "0" ]
then
	echo "Anda login sebagai `whoami`"
	echo "Silakan jalankan script sebagai root"
	echo
	exit 0
fi
if [ ! -f $file2 ]
then
	echo "#Acquire::http::proxy \"http://proxy3.pens.ac.id:443/\";" >> "$file2"
	echo "#Acquire::ftp::proxy \"ftp://proxy3.pens.ac.id:443/\";" >> "$file2"
	echo "#Acquire::https::proxy \"https://proxy3.pens.ac.id:443/\";" >> "$file2"
fi
testinet=`ping -c $count $server | grep received | awk -F',' '{print $2}' | awk '{print $1}'`
testproxy=`ping -c $count $proxy | grep received | awk -F',' '{print $2}' | awk '{print $1}'`
if [ "$testproxy" == "$count" ]
then
	echo "Koneksi ke $proxy lancar"
else
	echo "Koneksi $proxy mati"
fi
if [ "$testinet" == "$count" ]
then
	echo "Koneksi ke $server lancar"
else
	echo "Koneksi ke $server mati"
fi
if [ "$testinet" != "$count" ] && [ "$testproxy" == "$count" ]
then
	echo "Anda terkoneksi melalui jaringan PENS"
	if [ ! -f $file ]
	then
		echo -e "\033[31m File konfigurasi proxy (apt) tidak ada \033[0m"
		read -p "Buat file konfigurasi proxy? [Y/N]: " pilih
		if [ "$pilih" == "Y" ] || [ "$pilih" == "y" ]
		then
			sed 's/#//g' $file2 > $file
			echo "File konfigurasi telah di buat dan di aktifkan."
			apt-get update
		else
			exit 0
		fi
	else
		echo "Proxy telah di aktifkan.."
		apt-get update
	fi

elif [ "$testinet" == "$count" ] && [ "$testproxy" != "$count" ]
then
	echo "Anda terkoneksi melalui jaringan biasa"
	echo "Menghapus konfigurasi proxy..."
	if [ -f $file ]
	then
		rm $file
	fi
	apt-get update
fi
exit 0
