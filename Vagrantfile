###
### Push action requires: socat, screen
###

$box_name_server = "ubuntu/xenial64"
$box_name_client = "q2p/empty"
$server_ip = "192.168.2.2"
$client_socet = '/tmp/pxe_client_vm-socket'
$client_pty = '/tmp/pxe_client_vm-pty'

Vagrant.configure(2) do |config|
    config.vm.define "server", autostart: true do |server|
        server.vm.box = $box_name_server
        server.vm.hostname = "pxe-server"
        server.vm.network "private_network", ip: $server_ip, virtualbox__intnet: "pxe_network"
        server.vm.synced_folder "vagrant-volume/", "/vagrant-volume/" 
        server.vm.provision "ansible" do |ansible|
            ansible.playbook = "playbook.yml"
            ansible.extra_vars = { 'pxe_env': "#{ENV['pxe_env'] || "dev"}" }
        end
        server.vm.provider :virtualbox do |vb|
            vb.memory = '1024'
            vb.cpus = '1'
        end
    end
    
    config.vm.define "client", autostart: true do |client|
        client.ssh.insert_key = "false"
        client.vm.boot_timeout = 1
        client.vm.post_up_message = "Probably machine is unreachable by ssh. It's expected."
        client.vm.box = $box_name_client
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
                '--boot4', 'none',
                '--uart1', '0x3F8', '4',
                '--uartmode1', 'server', $client_socet
            ]
        end
    end

    config.push.define "local-exec" do |push|
        push.inline = <<-SCRIPT
        socat UNIX-CONNECT:$client_socet PTY,link=$client_pty &
        echo "Ctrl+A Ctrl+D for detach"
        sleep 5
        screen $client_pty
        SCRIPT
    end

end
