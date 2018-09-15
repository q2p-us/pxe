# PXE
Public configuration files and environment for testing

## Operations

### Dev
`vagrang up` or `pxe_env=dev vagrang up` will download **whole** ubuntu image (~800mb) and netboot tarball if it aren't presented already.  
Test server will be deployed with a PXE service, hosted preseed file and a http ubuntu mirror. This will provide a quite fast installation on test client.  
A good choice to start of developing a new feature.

### Stage
`pxe_env=stage vagrang up` will download only netboot tarball if it isn't presented already.  
Test server will be deployed with a PXE service but will use a global ubuntu mirror and preseed from [public gist](https://gist.github.com/b00men/40fb6781b8bc8b4d94ef15aa18c462c9). The speed of installation will depend on your connection speed.  
A good choice to check changes before publishing in a repository.

### Prod
`pxe_env=prod vagrang up` will download only netboot tarball if it isn't presented already.  
Test server will be deployed with a PXE service but will use a global ubuntu mirror and preseed from [repository](https://github.com/q2p-us/pxe/blob/master/preseed.txt). The speed of installation will depend on your connection speed.  
A good choice to check current status on production.

## TODO
- Prepare proper test's environment
    + emulation -- client will be connected to real server
- Post configuration (ipmi, ssh), take from _ks_gist.cfg_
- Add COM port configuration and testing
- Default action -- boot from hdd
- Simple remote trigger to install from pxe (variable for dhcp or tftpd)
- iPXE
- Describe in detailes development process
- Describe [q2p/empty.box](https://app.vagrantup.com/q2p/boxes/empty)

Based on [eoli3n/vagrant-pxe](https://github.com/eoli3n/vagrant-pxe) and [stephenrlouie/PXE-Boot-VM](https://github.com/stephenrlouie/PXE-Boot-VM)
