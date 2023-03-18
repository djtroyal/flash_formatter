#!/bin/bash

# Check if the user is root
if [ "$(id -u)" -ne 0 ]; then
  echo "This script must be run as root."
  exit 1
fi

# List all available USB devices
echo "Available USB devices:"
lsblk -d -o NAME,SIZE,MODEL | grep "sd"

# Ask user to select a USB device
read -p "Enter the name of the USB device to format: " usb_device

# Confirm the device selection
read -p "Are you sure you want to format $usb_device? This will erase all data on the device. [y/N] " confirm
if [[ "$confirm" != [yY] ]]; then
  echo "Aborting..."
  exit 1
fi

# List available filesystem types
echo "Available filesystem types:"
echo "1. ext2"
echo "2. ext3"
echo "3. ext4"
echo "4. btrfs"
echo "5. xfs"
echo "6. vfat"
echo "7. ntfs"
echo "8. exfat"
echo "9. hfs"
echo "10. hfs+"

# Ask user to select filesystem type
read -p "Enter the number of the filesystem type to use: " fs_type_num
case $fs_type_num in
  1)
    fs_type="ext2"
    ;;
  2)
    fs_type="ext3"
    ;;
  3)
    fs_type="ext4"
    ;;
  4)
    fs_type="btrfs"
    ;;
  5)
    fs_type="xfs"
    ;;
  6)
    fs_type="vfat"
    ;;
  7)
    fs_type="ntfs"
    ;;
  8)
    fs_type="exfat"
    ;;
  9)
    fs_type="hfs"
    ;;
  10)
    fs_type="hfsplus"
    ;;
  *)
    echo "Invalid filesystem type number."
    exit 1
    ;;
esac

# Unmount the USB device
echo "Unmounting the USB device..."
umount /dev/"$usb_device"

# Format the USB device
echo "Formatting the USB device with $fs_type filesystem..."
dd if=/dev/zero of=/dev/"$usb_device" bs=1M count=1 status=progress conv=fsync

# Use fdisk to create a new partition on the USB device
echo "Creating a new partition on the USB device..."
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/"$usb_device"

# Use mkfs to format the new partition with the selected filesystem type
echo "Formatting the new partition with $fs_type filesystem..."
mkfs."$fs_type" -v /dev/"$usb_device"1

echo "USB device formatting complete."
