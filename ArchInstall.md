# Instalação Arch Linux
# legacy

```bash
loadkeys pt-latin1                            # layour teclado portugues

ping -c 2 google.com

wifi-menu                                     # Se só tiver wireless

timedatectl set-ntp true

vim /etc/pacman.d/mirrorlist                  # meter os mirrors de Portugal no topo

lsblk                                         # verificar o nome do disco

#numa vm será d certeza 'sda'

cfdisk /dev/sda
      - escolher dos
      - criar swap partition e root
      - ao criar swap escolher type e escolher 82. Linux swap
      - write and quit

lsblk                                         # novamente para verificar as partiçoes criadas

mkfs.ext4 /dev/sda2                           # formata a partiçao no formato ext4, sda2 é a partiçao root criada acima

mkswap /dev/sda1
swapon /dev/sda1

mount /dev/sda2 /mnt

mais uma vez usar lsblk para verificar que o sda1 está como swap e sda2 está em /mnt

pacstrap /mnt base linux linux-firmware vim

genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab                            # verificar se está tudo bem

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Europe/Lisbon /etc/localtime

hwclock --systohc

vim /etc/locale.gen                           # tirar comment
locale.gen

vim /etc/locale.conf
  LANG=en_US.UTF-8

vim /etc/hostname > archoo
vim /etc/hosts
      127.0.0.1       localhost
      ::1             localhost
      127.0.0.1       archoo.localdomain     archoo

passwd

pacman -S grub networkmanager network-manager-applet dialog wireless_tools wpa_supplicant os-prober mtools dosfstools base-devel linux-headers

grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

exit
umount -a
reboot

systemctl start NetworkManager

ip a                                            # ver s tem ip

# wireless usar nmtui para ligar a uma rede

systemctl enable NetworkManager

useradd -m -G wheel <username>

passwd <username>

EDITOR=vim visudo                               # tirar comment do primeiro wheel

# instalar driver grafica
pacman -S xf86-video-intel or xf86-video-amdgpu # tentei usar mesa mas deu-m problemas, ficava tudo lento e por vezes o display manager nem aparecia neste caso teria d usar ctrl+f1..f8 até funcionar
                                                # este prob pode ser do vmware not sure
                                              
pacman -S xorg git

# A partir daqui é usar o que apetecer

pacman -S pulseaudio pavucontrol

# Instalar display manager 
# https://github.com/cylgom/ly

git clone https://github.com/cylgom/ly.git
make github
make
sudo make install
sudo systemctl enable ly.service
sudo systemctl disable getty@tty2.service

# agora ou instalar i3, xfce4 ou dwm...

pacman -S i3 ou xfce4 xfce4-goodies

reboot and have fun

# Problemas resoluçao vmware
Resolution

    1) Install OpenVMTools

    sudo pacman -S open-vm-tools

    2) Install drivers and libraries

    sudo pacman -Su xf86-input-vmmouse xf86-video-vmware xf86-video-amdgpu

    3) Create / Edit /etc/X11/Xwrapper.config

    sudo echo needs_root_rights=yes >>/etc/X11/Xwrapper.config

    4) Enable and start vmtoolsd.service

    sudo systemctl enable vmtoolsd

    sudo systemctl start vmtoolsd

# usar roboto regular do nerfonts

# ZSH

pacman -S zsh
chsh
      /bin/zsh

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc

```

# .zshrc
```bash
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/allancer/.zshrc'

## case-insensitive (uppercase from lowercase) completion
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
### case-insensitive (all) completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
### case-insensitive,partial-word and then substring completion
##zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source /home/allancer/Documents/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias pacman='pacman --color=auto'

# create a zkbd compatible hash;
# # to add other keys to this hash, see: man 5 terminfo
typeset -g -A key
#
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
#
# # setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete
#
# # Finally, make sure the terminal is in application mode, when zle is
# # active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
 	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
```
