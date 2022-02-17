# == arch auto installer == #
# (Inspired from bugswriter/arch-linux-magic script)

# Part 2 After chrooting into the new system
# When the script finishes you have a completely working archlinux
# You now need to download a DE / WM and the software you like

printf '\033c'
ls /usr/share/zoneinfo/
echo "Enter your region: "
read region
ls /usr/share/zoneinfo/$region
echo "Enter your city: "
read city
ln -sf /usr/share/zoneinfo/$region/$city /etc/localtime
hwclock --systohc
pacman -Syy --noconfirm sed vim
echo "Press enter, then uncomment your locale"
read waiting
vim /etc/locale.gen
locale-gen
printf '\033c'
echo "Enter your locale: "
read locale
echo "LANG=$locale" > /etc/locale.conf
echo "Enter your keymap: "
read keymap
echo "KEYMAP=$keymap" > /etc/vconsole.conf
echo "Enter the hostname of the computer where your are installing archlinux: "
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts
mkinitcpio -P
passwd
pacman --noconfirm -S grub efibootmgr os-prober
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=2/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
pacman --noconfirm -S networkmanager
systemctl enable NetworkManager
echo "Enter your username: "
read username
useradd -m -G wheel $username
passwd $username
echo "Press enter, then allow your user / group to use the sudo command"
read waiting
EDITOR=vim visudo
rm /part2.sh
echo "Done ! You can now reboot, and then install a DE, WM and the software you want"
echo "Have fun"
exit
