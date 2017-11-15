#hashicorp/precise32
$box_name = "ubuntu/xenial64"

Vagrant.configure(2) do |config|
    config.vm.define "server", autostart: true do |server|
        server.vm.box = $box_name
        server.vm.hostname = "pxe-server"
        server.vm.network "private_network", ip: "192.168.2.2", virtualbox__intnet: "pxe_network"
        #server.vm.synced_folder "netboot/", "/netboot/" 
        server.vm.provision :shell, path: "provision_scripts/general.sh"
        server.vm.provision :shell, path: "provision_scripts/dhcp.sh"
        server.vm.provision :shell, path: "provision_scripts/tftp.sh"
        server.vm.provision :shell, path: "provision_scripts/apache.sh"
        server.vm.provider :virtualbox do |vb|
            vb.memory = '1024'
            vb.cpus = '1'
        end
    end
    config.vm.define "client", autostart: true do |client|
        client.vm.boot_timeout = 1
        client.vm.post_up_message = "Probably machine is unreachable by ssh. It's expected."
        client.vm.box = "q2p/empty"
        client.vm.provider :virtualbox do |vb|
            vb.memory = '1024'
            vb.cpus = '1'
            vb.gui = 'true'
            vb.customize [
                'modifyvm', :id,
                '--nic1', 'intnet',
                '--intnet1', 'pxe_network',
                '--boot1', 'disk',
                '--boot2', 'net',
                '--boot3', 'none',
                '--boot4', 'none'
            ]
        end
    end
end
