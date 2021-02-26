FROM archlinux:base-devel

RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst && \
    curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && \
    bsdtar -C / -xvf "$patched_glibc"

# Add 'epita' user with password 'epita' and set root password to 'root'
RUN useradd -m -s /bin/zsh epita
RUN echo -e "epita\nepita" | passwd epita
RUN echo "epita ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN echo -e "root\nroot" | passwd

# Allows to install Cri packages and allows to add man pages
COPY cri-mirror /cri-mirror
RUN cat /cri-mirror >> /etc/pacman.conf
RUN sed -i 's-usr/share/man/\*--g' /etc/pacman.conf

# Updates pacman and install default packages
RUN pacman -Syyuu --noconfirm --ignore glibc
RUN pacman -S --noconfirm man man-db man-pages bash zsh
RUN pacman -S --noconfirm openssh git wget curl make cmake nano vim
RUN pacman -S --noconfirm autoconf libtool autoconf-archive m4

# Install C packages
RUN pacman -S --noconfirm gcc clang gdb valgrind boost
RUN pacman -S --noconfirm doxygen gcovr llvm criterion libev

# Install other packages
RUN pacman -S --noconfirm ruby go rust

# Install Python packages
RUN pacman -S --noconfirm python python-pip python-pytest python-pre-commit

# Install Oh-My-Zsh
USER epita
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt --depth=1
RUN ln -s ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship.zsh-theme

# Copy files and folder
USER epita
RUN touch /home/epita/.z
COPY home /home/epita
USER root
COPY root /

USER epita
ARG git_user_name="ADD_YOUR_NAME_HERE"
ARG git_user_email="ADD_YOUR_EMAIL_HERE"
RUN git config --global user.name "${git_user_name}"
RUN git config --global user.email "${git_user_email}"

RUN wget -O ~/.gitignore https://www.toptal.com/developers/gitignore/api/osx,vscode,c,c++,rust,go
RUN git config --global core.excludesfile "~/.gitignore"
USER root

RUN pacman -Scc --noconfirm

USER epita
WORKDIR /home/epita
ENTRYPOINT /bin/zsh
