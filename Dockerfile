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
USER epita
RUN git clone https://aur.archlinux.org/yay.git /home/epita/yay
RUN cd /home/epita/yay && makepkg --noconfirm -si
RUN rm -drf /home/epita/yay
USER root

# Install C packages
RUN pacman -S --noconfirm gcc clang gdb valgrind doxygen
RUN pacman -S --noconfirm gtk3 gcovr graphviz llvm gtest

USER epita
RUN yay -S --mflags --nocheck --noconfirm criterion lcov
USER root

# Install Go packages
RUN pacman -S --noconfirm go

# Install Ruby packages
RUN pacman -S --noconfirm ruby

# Install Rust packages
RUN pacman -S --noconfirm rust

# Install Python packages
RUN pacman -S --noconfirm python python-pip
RUN pip install --user pre-commit pytest

# Install Oh-My-Zsh
USER epita
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt --depth=1
RUN ln -s ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship.zsh-theme

# Copy files and folder
USER epita
COPY home /home/epita
USER root
COPY root /

USER epita
WORKDIR /home/epita
ENTRYPOINT /bin/zsh
