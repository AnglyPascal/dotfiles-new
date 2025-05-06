# this file needs to be a public git gist
# setup fstab, think about how to do that

root="/home/ahsan"
dots="$root/git/dots"
store="/run/mount/store"


link_directories () {
  ln -sf $store/git/ $root
  
  rm -r Desktop/ Documents/ Downloads/ Music/ Pictures/ Public/ Templates/ Videos/
  ln -sf $store/desktop/ $root
  ln -sf $store/documents/ $root
  ln -sf $store/downloads/ $root
  ln -sf $store/public/ $root
  ln -sf $store/pictures/ $root
  ln -sf $store/videos/ $root
  ln -sf $store/manga/ $root

  ln -sf $store/.software/ $root
}


setup_dots () {
  ln -sf $dots/.scripts/ $root
  ln -sf $dots/.themes/ $root

  for i in $dots/.*
  do 
    if [ -f $i ]; then
      ln -sf $i $root 
    fi
  done

  ln -sf $dots/.scripts $root 
  ln -sf $dots/.themes $root 
  ln -sf $dots/.vim $root 

  for i in $dots/.config/*
  do 
    rm -rf $root/.config/"${i##*/}" 
    ln -s $i $root/.config
  done

  ln -sf $root/.config/zsh/.zshrc $root

  for i in $dots/.local/share/applications/*
  do 
    ln -sf $i $root/.local/share/applications/
  done

  ln -sf $dots/.local/share/fonts/ $root/.local/share/
}


git_setup () {
  git config --global credential.helper store
}


install_packages () {
  printf "\r\033[2K  [ \033[00;32mDownloading Essential Packages\033[0m ] \n"

  sudo pacman-mirrors -c Bangladesh
  sudo pacman -Syu                                                                   \
    yay \
    brave-browser qutebrowser \
    alacritty \
    gvim neovim tig \
    polybar \
    dolphin \
    copyq \
    telegram-desktop discord  \
    python3 python-pip \
    gcc clang ccls clang-format cmake gdb valgrind \
    haskell-base jre-openjdk texlive \
    mpv shotcut maim feh gwenview \
    playerctl jpegoptim pdftk \
    zathura zathura-cb zathura-djvu zathura-pdf-mupdf calibre \
    adobe-source-han-sans-jp-fonts ttf-font-awesome ttf-hanazono \
    ttf-roboto noto-fonts-cjk noto-fonts-emoji \
    gthumb ffmpegthumbnailer ffmpegthumbs kvantum-qt5  nitrogen \
    unzip unrar p7zip perl-rename ripgrep konsole redshift awk zip \
    pipewire pipewire-pulse pipewire-alsa pavucontrol gst-plugin-pipewire \
    bluez bluez-utils blueman \
    gimp inkscape krita \
    rofi xclip \
    thunderbird nodejs npm \
    xournalpp \
    qemu-system-arm qemu-img \
    arm-none-eabi-gcc arm-none-eabi-gdb arm-none-eabi-binutils arm-none-eabi-newlib \
    neomutt gpg pinentry \
    conky \


  git clone --depth 1 https://github.com/wbthomason/packer.nvim   \
    ~/.local/cabalshare/nvim/site/pack/packer/start/packer.nvim

  sudo pacman -Rncs viewnior vlc palemoon-bin pamac-cli pamac-gtk clipit

  # set qute as the default browser
  xdg-mime default                      \
    org.qutebrowser.qutebrowser.desktop \
    x-scheme-handler/https              \
    x-scheme-handler/http

  # setup latex stylesheets
  sudo ln -s /home/ahsan/git/sty /usr/share/texmf-dist/tex/latex/
  sudo texhash
}


install_omz (){
  # install oh my zsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  chsh -s $(which zsh)
  curl -sS https://starship.rs/install.sh | sh
  echo ''
}


install_yay_pip () {
  printf "\r\033[2K  [ \033[00;32mDownloading AUR and Pip Packages\033[0m ] \n"
    
  # to import the spotify gpg key
  curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -

  info 'installing yay packages'
  yay -S spotify librsvg megasync findimagedupes onedrive-abraunegg mcomix gopreload-git gcalcli

  info 'installing pip packages'
  /usr/bin/pip install pynvim numpy scipy matplotlib pyplot yt-dlp cyberdrop-dl     \
      --break-system-packages

  python -m venv .venv
  source .venv/bin/activate

  pip install pynvim numpy scipy matplotlib pyplot yt-dlp cyberdrop-dl     \
    black-macchiato catppuccin

  echo ''
}


tearfree () {
   sudo cp $dots/.sys/10-amdgpu.conf /etc/X11/xorg.conf.d
}


install () {
  link_directories
  setup_dots
  git_setup
  install_packages
  install_omz
  install_yay_pip
}


