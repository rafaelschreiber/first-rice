#!/usr/bin/env bash
# Author:       Rafael Schreiber
# Date:         28-03-2019 

printf "You are running this script without any warranty!\n"
printf "At the end this script will perform a reboot!\n"
printf "Please make sure that your account have root/sudo privilegies!\n\n"

printf "Press CTRL+C to cancel: "
read accept

echo "Installing packages..."
sudo pacman -S --noconfirm base-devel xorg xorg-server xorg-xinit i3 mesa python python-pip git python-dbus fish neofetch code ranger termite exa rofi cmatrix htop feh compton playerctl pulseaudio noto-fonts scrot
sudo pacman -R --noconfirm i3lock # in conflict with i3-lock-fancy
echo "Packages installed!"
sleep 1

echo "Installing needed PGP keys for AUR packages..."
gpg --recv-keys A87FF9DF48BF1C90
echo "Keys added!"
sleep 1

echo "Installing AUR packages"
git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ..
yaourt -S google-chrome i3lock-fancy-git micro nerd-fonts-hack spotify polybar pulseaudio-ctl
echo "AUR packages installed!"
sleep 1

echo "Installing dotfiles..."
# creating directories if needed
mkdir -p $HOME/.config
mkdir -p $HOME/Pictures/Wallpapers

# backing up
mv $HOME/.config/compton $HOME/.config/compton-old 2>/dev/null
mv $HOME/.config/fish $HOME/.config/fish-old 2>/dev/null
mv $HOME/.config/i3 $HOME/.config/i3-old 2>/dev/null
mv $HOME/.config/polybar $HOME/.config/polybar-old 2>/dev/null
mv $HOME/.config/termite $HOME/.config/termite-old 2>/dev/null
mv $HOME/.bash_profile $HOME/.bash_profile-old 2>/dev/null
mv $HOME/.xinitrc $HOME/.xinitrc-old 2>/dev/null
mv $HOME/.Xmodmap $HOME/.Xmodmap-old 2>/dev/null

# installing new dotfiles
cp -r config/* $HOME/.config/
cp Pictures/Wallpapers/DaS.png $HOME/Pictures/Wallpapers/
cp bash_profile $HOME/.bash_profile
cp xinitrc $HOME/.xinitrc
cp Xmodmap $HOME/.Xmodmap 
echo "Dotfiles installed!"
sleep 1

echo "Installing necessary scripts..."
sudo cp scripts/* /usr/local/bin/
echo "Scripts installed!"
sleep 1

echo "Applying initrd patches for apple keyboards..."
sudo bash -c "echo 'options hid_apple fnmode=2' > /etc/modprobe.d/hid_apple.conf"
sudo mkinitcpio -p linux
echo "Patches applied!"
sleep 1

echo "Doing post-installation stuff..."
systemctl --user enable pulseaudio.service
echo "Done!"
sleep 1

echo "Rebooting..."
reboot