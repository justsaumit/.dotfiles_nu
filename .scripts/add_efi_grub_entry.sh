#!/bin/bash

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root (use sudo)"
    exit 1
fi

# Get the EFI partition
echo "Identifying EFI partitions..."
efiparts=$(sudo fdisk -l | grep "EFI System" | awk '{print $1}')
echo "Detected EFI partition: $efiparts"

# Prompt user to select an EFI partition
[ $(command -v fzf) ] && efipart=$(echo "$efiparts" | fzf --prompt="Select an EFI partition: ") || \
    echo "Please enter the full path of the EFI partition you want to use (e.g., /dev/nvme0n1p1):" && read efipart

# Get the UUID of the EFI partition
uuid=$(sudo blkid "$efipart" | awk -F '"' '{print $2}')
echo "Detected UUID: $uuid"

# Grant write permission to the 40_custom file
echo "Granting write permissions to /etc/grub.d/40_custom..."
chmod o+w /etc/grub.d/40_custom

# Add Windows entry to 40_custom
echo "Adding Windows 11 entry to GRUB..."
cat <<EOF >> /etc/grub.d/40_custom

menuentry 'Windows 11' {
    search --fs-uuid --no-floppy --set=root $uuid
    chainloader (\$root)/EFI/Microsoft/Boot/bootmgfw.efi
}
EOF

# Remove write permission from the 40_custom file
echo "Removing write permissions from /etc/grub.d/40_custom..."
chmod o-w /etc/grub.d/40_custom

# Update GRUB
echo "Updating GRUB..."
sudo grub-mkconfig -o /boot/grub/grub.cfg 
# Verification (Optional)
echo "Verifying the changes..."
grep -A 10 'Windows 11' /boot/grub/grub.cfg

echo "Windows 11 entry added successfully!"
