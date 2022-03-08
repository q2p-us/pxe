# PXE
Public configuration files and environment for testing

## Operations

### Dev
`vagrant up` or `pxe_env=dev vagrant up` will download **whole** k3os iso image (~500mb) and kernel+initrd (grub patch for ttyS0 included) if they aren't presented already.  
Test server will be deployed with a PXE service, hosted k3os iso image. This will provide a quite fast installation on test client.  
A good choice to start of developing a new feature.

### Prod
`pxe_env=prod vagrant up` will download only k3os kernel and initrd if they aren't presented already.  
Test server will be deployed with a PXE service but will use an official k3os iso image url. The speed of installation will depend on your connection speed.  
A good choice to check current status on production.

### Known issues

#### Client VM stuck on pxe load

VM for a client might be paused on loading of `pxelimux.0` due awaiting of a serial console. In order to resolve the issue:

1. Install dependencies `socat`, `screen`
2. Do `vagrant push` to activate serial console client

## OpenWRT

A raw example of OpenWRT configuration as PXE server

```
ssh root@wifi mkdir /tftpboot
scp -r /vagrant-volume/tftpboot/* root@wifi:/tftpboot/
ssh root@wifi chmod -R 777 /tftpboot
ssh root@wifi chown -R nobody /tftpboot

ssh root@wifi:~# nano /etc/config/dhcp
	
    add into "config dnsmasq" section
		option enable_tftp '1'
		option tftp_root '/tftpboot'

	config boot linux
        option filename 'pxelinux.0'
        option serveraddress 'IP_OF_THE_ROUTER'
        option servername 'OpenWRT'
```

## TODO
- Describe COM port configuration and testing
- Describe PXE sources
- iPXE
- Describe [q2p/empty.box](https://app.vagrantup.com/q2p/boxes/empty)

Based on [eoli3n/vagrant-pxe](https://github.com/eoli3n/vagrant-pxe) and [stephenrlouie/PXE-Boot-VM](https://github.com/stephenrlouie/PXE-Boot-VM)
