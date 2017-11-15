# PXE
Public configuration files and environment for testing

## Operations
`vagrang up` -- download sources, test

## TODO
- Prepare proper test's environment
    + dev -- quick install, http based
    + stage -- gist based (https)
    + prod -- github based
    + emulation -- client will be connected to real server
- Post configuration (ipmi, ssh), take from _ks_gist.cfg_
- Move preseed to submodule
- Add COM port configuration and testing
- Default action -- boot from hdd
- Simple remote trigger to install from pxe (variable for dhcp or tftpd)
- Describe in detailes development process
- Describe [q2p/empty.box](https://app.vagrantup.com/q2p/boxes/empty)

Based on [eoli3n/vagrant-pxe](https://github.com/eoli3n/vagrant-pxe)