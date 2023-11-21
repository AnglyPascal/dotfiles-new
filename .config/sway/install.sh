git config --global user.email "ahsanalmahir@gmail.com"
git config --global user.name "M Ahsan Al Mahir"
git config --global credentials.helper store

fs_setup() {
  echo "UUID=f7925555-e6f3-4f91-9261-59e2b07de8e4 /run/media/store  ext4    defaults,noatime 0 1" | sudo tee -a "/etc/fstab"
  sudo mount /dev/nvme0n1p3 "/run/media/store"

  ln -s "/run/media/store/git" "$HOME/git"
}

fonts_setup() {
  fonts=(
    ttf-roboto noto-fonts-cjk noto-fonts noto-fonts-emoji 
    ttf-font-awesome ttf-hanazono texlive-fontsextra
  )

  sudo pacman -S ${fonts[@]}
  sudo pacman -R gnu-free-fonts
}

install=(
  # essential
  neovim gvim alacritty
  # browser
  qutebrowser brave-browser dolphin
  # adblock
  python-pip python-adblock python-i3pc 
  # socials
  telegram-desktop discord
  # languages
  jre-openjdk texlive base-devel jenv
  # media
  mpv shotcut feh gwenview jpegoptim yt-dlp
  # docs
  zathura-cb zathura-djvu calibre pdfjs xournalpp pdftk
  # tools
  unzip unrar p7zip perl-rename ripgrep 
  konsole awk zip tree tig
  # bluetooth
  bluez bluez-utils blueman 
  # art
  gimp inkscape krita thunderbird darktable
  # network
  ifplugd inxi 
  # fingerprint authenticator
  fprintd 
  # yay
  yay 
  # power saving
  tlp
  # email
  aerc w3m dante
)

maybe=(
  copyq
)

remove=(
  firefox
)

install_aur=(
  spotify spicetify-cli zoom librsvg 
  megasync findimagedupes 
  onedrive-abraunegg
)

misc() {
  # setup latex styles
  mkdir -p "$HOME/texmf/tex/latex/"
  ln -s "/home/ahsan/git/sty" "$HOME/texmf/tex/latex/"

  # set qute as the default browser
  xdg-mime default                      \
    org.qutebrowser.qutebrowser.desktop \
    x-scheme-handler/https              \
    x-scheme-handler/http

  # install plug
  curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
      "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
}


zsh_setup() {
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
      ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

fingerprint_setup() {
  pass="auth 	  [success=1 new_authtok_reqd=1 default=ignore]  	pam_unix.so try_first_pass likeauth nullok"
  fprint="auth 	  sufficient  	pam_fprintd.so"

  sudo sed -i "3 i $fprint" /etc/pam.d/system-local-login
  sudo sed -i "3 i $pass" /etc/pam.d/system-local-login

  sudo sed -i "3 i $fprint" /etc/pam.d/login
  sudo sed -i "3 i $pass" /etc/pam.d/login

  # sudo sed -i "3 i $pass" /etc/pam.d/sudo
}

eduroam_setup() {
  sudo pacman -S dbus-python
  python $HOME/.scripts/eduroam-linux-UoO-Oxford_Users.py
  sudo pacman -R dbus-python
}


# fs_setup

# sudo pacman -S ${install[@]}
# sudo pacman -S ${maybe[@]}
# sudo pacman -Rncs ${remove[@]}
#
# yay -S ${install_aur[@]}
#
# fonts_setup
# misc
# zsh_setup
# eduroam_setup
#
#
# remove_digikam() {
#   sudo pacman -Rncs digikam
#   rm -rf .local/share/digikam/
# }
