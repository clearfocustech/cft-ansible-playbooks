This playbook will provision a new virtual machine in ESXi and install CentOS on it.
You will need the rpm packages for python-pyvmomi, python-requests, isomd5sum and genisofs on the ansible server

An example ansible hosts file entry for this is below:
> my_hostname ip=192.168.1.86 netmask=255.255.255.0 gateway=192.168.1.1 subnet=192.168.1.0 esxi_ip=192.168.1.176 esxi_host=localhost.localdomain cpu_count=2 ram_mb=4096 disk_gb=32 vm_network="VM Network" datastore=datastore1 iso_image="/home/user/Downloads/CentOS-7-x86_64-Minimal-1908.iso"

esxi_host is the hostname of the esxi host in vcenter

some variables are set at the top of the playbook, such as the datacenter name and where to store ISO files 