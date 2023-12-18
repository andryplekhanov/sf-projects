[app]
vm2 ansible_ssh_host=${vm2_ip} ansible_user=${user}
vm3 ansible_ssh_host=${vm3_ip} ansible_user=${user}

[database]
vm1 ansible_ssh_host=${vm1_ip} ansible_user=${user} version=12 data_dir=/data/postgresql

[web]
vm1 ansible_ssh_host=${vm1_ip} ansible_user=${user}