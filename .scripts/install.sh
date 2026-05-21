#!/bin/bash

set -euo pipefail

root="$HOME"
dots="$root/git/dots"
store="/run/mount/store"
WITH_OPTIONAL=false

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # no color

# Optional flag
if [[ "${1:-}" == "--with-optional" ]]; then
  WITH_OPTIONAL=true
fi

# Packages installed on every run
PACMAN_BASE=(
  yay
  brave-browser qutebrowser
  alacritty
  i3status-rust
  gvim neovim tig
  dolphin
  telegram-desktop
  python python-pip
  gcc clang ccls cmake gdb valgrind
  meson base-devel ninja
  ccache cloudflared npm
)

# Extra packages installed only with --with-optional
PACMAN_OPTIONAL=(
  polybar copyq discord
  haskell-base jre-openjdk texlive
  mpv shotcut maim feh gwenview
  playerctl jpegoptim pdftk
  zathura zathura-cb zathura-djvu zathura-pdf-mupdf calibre
  adobe-source-han-sans-jp-fonts ttf-font-awesome ttf-hanazono
  ttf-roboto noto-fonts-cjk noto-fonts-emoji
  gthumb ffmpegthumbnailer ffmpegthumbs kvantum-qt5 nitrogen
  unzip unrar p7zip perl-rename konsole redshift awk zip
  pipewire pipewire-pulse pipewire-alsa pavucontrol gst-plugin-pipewire
  bluez bluez-utils blueman
  gimp inkscape krita
  rofi xclip thunderbird nodejs npm
  xournalpp
  qemu-system-arm qemu-img
  arm-none-eabi-gcc arm-none-eabi-gdb arm-none-eabi-binutils arm-none-eabi-newlib
  neomutt gpg pinentry
  conky
  bat dust duf ripgrep fd
)

# Packages removed during the optional run
PACMAN_REMOVE=(
  viewnior vlc palemoon-bin pamac-cli pamac-gtk clipit
)

# AUR packages (installed via yay)
YAY_PACKAGES=(
  spotify librsvg megasync findimagedupes onedrive-abraunegg mcomix gopreload-git gcalcli
)

# Python packages
PIP_PACKAGES=(
  pynvim numpy scipy matplotlib pyplot yt-dlp cyberdrop-dl
)

# Extra Python packages installed only in the venv
PIP_VENV_EXTRA=(
  black-macchiato catppuccin
)

log_success() {
  printf "${GREEN}✓ SUCCESS${NC} - $1\n"
}

log_failure() {
  printf "${RED}✗ FAILURE${NC} - $1\n"
}

run_step() {
  local name="$1"
  shift
  if "$@"; then
    log_success "$name"
  else
    log_failure "$name"
    exit 1
  fi
}

link_directories() {
  ln -sf "$store/git/" "$root"

  rm -rf "$root"/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}

  ln -sf "$store/desktop/" "$root"
  ln -sf "$store/documents/" "$root"
  ln -sf "$store/downloads/" "$root"
  ln -sf "$store/public/" "$root"
  ln -sf "$store/pictures/" "$root"
  ln -sf "$store/videos/" "$root"
  ln -sf "$store/manga/" "$root"
  ln -sf "$store/.software/" "$root"
}

setup_dots() {
  ln -sf "$dots/.scripts/" "$root"
  ln -sf "$dots/.themes/" "$root"
  ln -sf "$dots/.vim" "$root"

  for i in "$dots"/.*; do
    [[ -f "$i" ]] && ln -sf "$i" "$root"
  done

  for i in "$dots/.config/"*; do
    rm -rf "$root/.config/${i##*/}"
    ln -s "$i" "$root/.config"
  done

  ln -sf "$root/.config/zsh/.zshrc" "$root"

  for i in "$dots/.local/share/applications/"*; do
    ln -sf "$i" "$root/.local/share/applications/"
  done

  ln -sf "$dots/.local/share/fonts/" "$root/.local/share/"
}

git_setup() {
  git config --global credential.helper store
}

install_packages() {
  sudo pacman-mirrors -c United_Kingdom
  sudo pacman -Syu --noconfirm

  sudo pacman -S --needed "${PACMAN_BASE[@]}"

  if [ "$WITH_OPTIONAL" = true ]; then
    sudo pacman -S --noconfirm --needed "${PACMAN_OPTIONAL[@]}"

    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
      ~/.local/cabalshare/nvim/site/pack/packer/start/packer.nvim

    sudo pacman -Rncs --noconfirm "${PACMAN_REMOVE[@]}"

    xdg-mime default org.qutebrowser.qutebrowser.desktop x-scheme-handler/http
    xdg-mime default org.qutebrowser.qutebrowser.desktop x-scheme-handler/https

    sudo ln -sf "$root/git/sty" /usr/share/texmf-dist/tex/latex/
    sudo texhash
  fi
}

install_omz() {
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  chsh -s "$(which zsh)"
  curl -sS https://starship.rs/install.sh | sh
}

install_yay_pip() {
  curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -

  yay -S --noconfirm "${YAY_PACKAGES[@]}"

  /usr/bin/pip install --break-system-packages "${PIP_PACKAGES[@]}"

  python -m venv "$root/.venv"
  source "$root/.venv/bin/activate"

  pip install "${PIP_PACKAGES[@]}" "${PIP_VENV_EXTRA[@]}"
}

tearfree() {
  if lspci | grep -i 'vga' | grep -qi 'amd'; then
    sudo cp "$dots/.sys/10-amdgpu.conf" /etc/X11/xorg.conf.d
  else
    echo "Skipping tearfree: not an AMD GPU"
  fi
}

main() {
  run_step "Link directories" link_directories
  run_step "Setup dotfiles" setup_dots
  run_step "Git configuration" git_setup
  run_step "Install packages" install_packages
  run_step "Install Oh My Zsh + Starship" install_omz
  run_step "Install yay & pip packages" install_yay_pip
  run_step "Enable AMDGPU tearfree (if AMD GPU)" tearfree
}

main
