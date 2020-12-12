FROM archlinux

# Updates all packages and install default packages
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm sudo openssh git wget curl nano awk zsh base-devel make cmake
RUN git clone https://aur.archlinux.org/yay.git && cd yay && makepkg --noconfirm -si

# Allows to add man pages
RUN sed -i 's-usr/share/man/\*--g' /etc/pacman.conf
RUN pacman -S --noconfirm man man-pages man-db

# Install C packages
RUN pacman -S --noconfirm gcc clang gdb gtk3 valgrind gcovr doxygen graphviz llvm gtest
RUN yay -S --mflags --nocheck --noconfirm criterion lcov

# Install Go packages
RUN pacman -S --noconfirm go

# Install Ruby packages
RUN pacman -S --noconfirm ruby

# Install Rust packages
RUN pacman -S --noconfirm rust

# Install Python packages
RUN pacman -S --noconfirm python python-pip
RUN pip install --user pre-commit pytest

# Set root password to 'root'
RUN echo -e "root\nroot" | passwd

# Add 'epita' user
RUN useradd -m -s /bin/bash epita
RUN echo -e "epita\nepita" | passwd epita
RUN echo "epita ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENTRYPOINT /bin/bash
