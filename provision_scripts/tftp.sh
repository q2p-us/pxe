apt-get install -y xinetd tftpd tftp
cp /vagrant/provision_files/tftp /etc/xinetd.d/tftp
sudo mkdir /tftpboot
#ln -s /netboot /tftpboot/netboot
cp -R /netboot/* /tftpboot
sudo chmod -R 777 /tftpboot
sudo chown -R nobody /tftpboot
sudo service xinetd restart
