### Notes
- The License key (win_key) must match the verison and product of Windows on the ISO image. This respository currently uses 2019 Essentials
- The disk partitioning in autounattend.xml must match the drives and UEFI or BIOS. ESXi 7 uses EFI, so this template matches that.

- This playbook requires at least 3x the disk space of the Windows ISO you are using. It requires, the orignial, and extracted copy of the original, and a new iso made without a key press prompt. This is typically 15G plus per Windows version.

- There are some hard-coded variables at the top of the script, configure these for your environment

- To run this playbook from the LInux CLI: ansible-playbook ./install-windows-esxi.yml -l test-win10 -i inventory.txt -b -k -K -u root
- The esxi_host variable must be the name of the ESXi server, from its perspective (not neccessarily matching DNS)
- The script will prompt for the credentials for vsphere, user root and the password to the esxi host (even if you have vcenter)
