sudo apt-get install -y nginx
mkdir /var/www/html/images/
#cp /vagrant/provision_files/test.txt /var/www/images/test.txt
#cp /netboot/mini_ubuntu_32.iso /var/www/images/my_ubuntu_32.iso
#ln -s /netboot/ubuntu-installer/amd64/linux /var/www/html/images/linux
#ln -s /netboot/ks.cfg /var/www/html/ks.cfg
#ln -s /netboot/ubuntu-installer/amd64/initrd.gz /var/www/html/images/initrd.gz
#ln -s /vagrant/ubuntu /var/www/html/ubuntu

cp /netboot/ubuntu-installer/amd64/linux /var/www/html/images/linux
#cp /netboot/ks.cfg /var/www/html/ks.cfg
cp /vagrant/preseed.txt /var/www/html/preseed.txt
cp /netboot/ubuntu-installer/amd64/initrd.gz /var/www/html/images/initrd.gz
cp -a /vagrant/ubuntu /var/www/html/ubuntu

sudo chmod 777 -R /var/www
sudo chown -R nobody /var/www

sysctl -w net.ipv4.ip_forward="1"


iptables -t nat -A POSTROUTING -o $(ip r | grep default | cut -d ' ' -f 5) -j MASQUERADE