FROM archlinux:base-devel

# Set root password to 'root'
RUN echo -e "root\nroot" | passwd

# Add 'epita' user with password 'epita'
RUN useradd -m -s /bin/zsh epita
RUN echo -e "epita\nepita" | passwd epita

# Allows to add man pages
RUN sed -i 's-usr/share/man/\*--g' /etc/pacman.conf

# Updates all packages
RUN pacman -Syu --noconfirm

# Install default packages
RUN pacman -S --noconfirm man man-pages man-db
RUN pacman -S --noconfirm sudo openssh git wget curl
RUN pacman -S --noconfirm nano awk zsh base-devel make cmake
RUN echo "epita ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install Yay for AUR packages
RUN runuser -l epita -c 'git clone https://aur.archlinux.org/yay.git'
RUN runuser -l epita -c 'cd yay && makepkg --noconfirm -si'
RUN rm -drf /home/epita/yay

# Install C packages
RUN pacman -S --noconfirm gcc clang gdb valgrind doxygen
RUN pacman -S --noconfirm gtk3 gcovr graphviz llvm gtest
RUN runuser -l epita -c 'yay -S --mflags --nocheck --noconfirm criterion lcov'

# Install Go packages
RUN pacman -S --noconfirm go

# Install Ruby packages
RUN pacman -S --noconfirm ruby

# Install Rust packages
RUN pacman -S --noconfirm rust

# Install Python packages
RUN pacman -S --noconfirm python python-pip
RUN pip install --user pre-commit pytest

# Copy files and folder
COPY home /home/epita
COPY root /

ENTRYPOINT /bin/zsh
