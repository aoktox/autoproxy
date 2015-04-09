Otomatis mengatur proxy ketika terkoneksi ke jaringan EEPIS (PENS)

Compatibility
=============

**Operating Systems:**

 + Debian 6 (Squeeze) 64 Bit
 + Debian 6 (Squeeze) 32 Bit
 + Ubuntu 12.04 (Precise Pangolin) 32 Bit
 + Ubuntu 12.04 (Precise Pangolin) 64 Bit

====================================================

**Prinsip kerja :**

 + Mengecek apakah laptop terkoneksi ke internet
 + Mengecek apakah koneksi menggunakan jaringan PENS atau bukan
 + Jika koneksi menggunakan jaringan PENS maka script akan otomatis membuat konfigurasi proxy untuk APT
 + Jika koneksi menggunakan jaringan umum, konfigurasi proxy (APT) akan di hapus.
Fungsi

Instructions
============

**Download Autoproxy**

To download auto proxy use the following command:

	wget --no-check-certificate -O autoproxy.zip https://github.com/aoktox/autoproxy/archive/master.zip; unzip -d /bin/ autoproxy.zip; rm autoproxy.zip

**run the script**

use the following command:

	bash /bin/autoproxy.sh

**Remove autoproxy**

To remove the Minstall script run the following command under the same user you installed Minstall under:

	rm -f /bin/autoproxy.sh

