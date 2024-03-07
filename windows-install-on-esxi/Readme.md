### System Requirements
- These playbooks call linux commands and must run on an Linux Ansible host
- genisoimage must be installed to rebuild the Windows ISOs to make them bootable
- pyVMomi (pyhton3-pyvmomim) must be installed
- p7zip is needed to extract the Windows ISOs to make them bootable

## What it does
- This playbook creates a new guets in VMware and installs a Windows 7, 8, 10, 11, or Server 2019 operating system on it. It assigns a static IP, disables the firewall, and enables PSRemoting. These 3 actions are sufficient to allow all follow on configuration to take place via other Ansible scripts.
- The is accomplished by, in order: extracting the contents of an ISO downloaded from Microsoft and removing the "Press any keey to boot from CD ROM", making a new bootable ISO with the suffix -no-prompt.iso, populating values from the Ansible inventory into an autounattend.xml file, placing the autounattaend.xml on a 2nd CD-ROM/ISO image, also placing a PowerShell script(which is called in the autounattend.xml) on the 2nd ISO image which sets the IP, disables the Firewall, and enables PS-Remoting, then uploading the 2 ISO images to ESXi, then creating a nerw guest on ESXi and assigning it 2 CD-ROM drives for the 2 ISOs.

## expected ansible host variables
Looking at the example inventory is probably as good an exmplanation as any.
- local_admin: The acocunt name for the user with Administrator privileges. 
- local_admin_pass: The password for the above account. Also used for the Administrator account on Windows 2019.
- win_key: the license key for Windows. This determines what WIndows product is installed (Home versus Pro, Standard versus Datacenter)
- unattend: the J2 templated autounattend.xml file to use. Sampls are provided in the templates folder which can be used as-is, or modified if required.
- iso_image: The name of the ISO images file downloaded from Microsoft. Should be placed in the isos folder.
- disk_gb: Gigabytes of disk space to assign to the guest
- ram_mb: megabytes of RAM to assign the guest
- cpu_count: How many cores to assign the guest
- vm_network: The name of the virtual network in vCenter for the guest
- vsphere_hostname
- vsphere_username
- vsphere_password
- vsphere_datastore: Where to place the guest
- vsphere_iso_datastore: Where to upload the ISOs to

### Notes
- The License key (win_key) must match the verison and product of Windows on the ISO image. This respository currently uses 2019 Essentials
- The disk partitioning in autounattend.xml must match the drives and UEFI or BIOS. ESXi 7 uses EFI, so this template matches that.

- This playbook requires at least 3x the disk space of the Windows ISO you are using. It requires, the orignial, and extracted copy of the original, and a new iso made without a key press prompt. This is typically 15G plus per Windows version.

- There are some hard-coded variables at the top of the script, configure these for your environment

- To run this playbook from the LInux CLI: ansible-playbook ./install-windows-esxi.yml -l test-win10 -i inventory.txt -b -k -K -u root
- The esxi_host variable must be the name of the ESXi server, from its perspective (not neccessarily matching DNS)
- The script will prompt for the credentials for vsphere, user root and the password to the esxi host (even if you have vcenter)
- The boot_firmware for the vm (either bios or efi) must match the disk configuration in the autounattend.xml 

- The vmware guest_id is hardcoided to Windows9_64Guest
- The autoattend.xml templates provided call a Powershell script to set the IP address, disable the firewall, and enable PSRemoting. 
