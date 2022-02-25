#!/bin/sh

# == arch auto installer == #
# (Inspired from bugswriter/arch-linux-magic script)

# Part 1 Before chrooting into the new system

# Make sure to :
# - have an internet connection
# - be booted in efi boot mode
# - having your keyboard layout configure correctly

printf '\033c'
echo "Welcome to Mathis-R's archlinux installer"
timedatectl set-ntp true
lsblk
echo "Enter the drive: "
read drive
cfdisk $drive 
echo "Enter the linux partition: "
read partition
mkfs.ext4 $partition
echo "Enter EFI partition: "
read efipartition
read -p "Did you created it? [y/n] " answer
if [[ $answer = y ]] ; then
  mkfs.fat -F 32 $efipartition
fi
read -p "Did you also create a swap partition? [y/n] " answer
if [[ $answer = y ]] ; then
  echo "Enter Swap partition: "
  read swappartition
  mkswap $swappartition
  swapon $swappartition
fi
mount $partition /mnt
mkdir /mnt/boot
mount $efipartition /mnt/boot
echo "Enter your country (using reflector for better download speed): "
read country
reflector --country $country --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist 
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
cp /root/my-arch-installer/part2.sh /mnt/part2.sh 
chmod +x /mnt/part2.sh
printf '\033c'
#echo "Enter \"chmod +x part2.sh\" , then run it with ./part2.sh"
arch-chroot /mnt ./part2.sh
exit 
