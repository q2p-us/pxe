apt-get update
apt-get install -y curl tftp p7zip-full


# preparing
cd /vagrant/
rm -rf netboot
tarball="http://archive.ubuntu.com/ubuntu/dists/xenial-updates/main/installer-amd64/current/images/netboot/netboot.tar.gz"
test -e netboot.tar.gz || wget ${tarball} -O netboot.tar.gz
mkdir netboot
tar zxf netboot.tar.gz -C netboot


iso="http://releases.ubuntu.com/16.04/ubuntu-16.04.3-server-amd64.iso"
test -e ubuntu || (
	wget ${iso} -O ubuntu.iso
	mkdir ubuntu
	7z x ubuntu.iso -oubuntu/
	rm -rf ubuntu.iso
	) 


cp ks.cfg netboot/
cp syslinux.cfg netboot/ubuntu-installer/amd64/boot-screens/
cp -a netboot /netboot
#caused problems with GRUB boot loader
#apt-get -y upgrade
