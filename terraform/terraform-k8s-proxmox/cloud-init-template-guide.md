# 🛠️ Proxmox Cloud-Init Template Setup

### 1. Download the Ubuntu 24.04 Cloud Image

https://cloud-images.ubuntu.com/releases/24.04/release/

### 2. Upload and Create Template on Proxmox

```bash
qm create 9000 --name ubuntu-cloudinit-template --memory 1024 --net0 virtio,bridge=vmbr0
qm importdisk 9000 ubuntu-24.04-server-cloudimg-amd64.img local-lvm
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
qm set 9000 --ide2 local-lvm:cloudinit
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --serial0 socket --vga serial0
qm template 9000
```

✅ You can now use `ubuntu-cloudinit-template` in Terraform to clone new VMs.
