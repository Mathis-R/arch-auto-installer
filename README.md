# arch-auto-installer
(Inspired from Bugswriter/arch-linux-magic script)

## Make sure to read the script and configure it to fit your needs

### Also make sure to :
 - have an internet connection (run  $ `ip a` and look for an ip address)
 - be booted in efi boot mode (run  $ `ls /sys/firmware/efi/efivars` if no errors your are in UEFI)
 - having your keyboard layout configure correctly ($ `loadkeys *your-layout*`)
 
---

First, boot on your USB with the archlinux ISO \
Then run \
$ `pacman -Syy git` \
Then \
$ `git clone https://github.com/Mathis-R/arch-auto-installer` \
Then \
`./part1.sh` \
Then follow the instructions \
Congratulations ! You now have a working archlinux system \
Now you need to install a DE / WM , and the software you want to use \
*Have Fun !*

---

Part1 run the first part of the installation (before chrooting into the new system) \
It will by itself run Part2 after automatically chrooting
