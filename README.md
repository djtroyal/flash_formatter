# USB Device Formatter

This script helps you format a USB device with a selected filesystem type. It lists available USB devices and filesystem types, allowing you to choose the desired options before formatting the device.

## Prerequisites

- `fdisk`
- `mkfs`
- `lsblk`
- `dd`

These tools should be pre-installed on most Linux distributions.

## Usage

1. Clone this repository or download the `usb_device_formatter.sh` script.
2. Make the script executable: `chmod +x usb_device_formatter.sh`
3. Run the script as root or using sudo: `sudo ./usb_device_formatter.sh`

The script will list all available USB devices and ask you to select the one you want to format. It will then list the supported filesystem types and prompt you to choose the desired filesystem. After confirming your selection, the script will format the USB device with the selected filesystem type.

**Warning: This script will erase all data on the selected USB device. Make sure to backup any important data before running this script.**

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
