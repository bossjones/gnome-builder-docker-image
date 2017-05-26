FROM fedora:rawhide

MAINTAINER Leandro Santiago <leandrosansilva@gmail.com>

# Ensure UTF-8 lang and locale
# RUN localedef -i en_US -f UTF-8 en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

RUN ["/bin/bash", "-c", "echo hello"]

RUN dnf -y update && \
    dnf -y install gio-2.0 \
                   gio-unix-2.0 \
                   gtk+-3.0 \
                   gtksourceview-3.0 \
                   gspell-1 \
                   enchant \
                   json-glib-1.0 \
                   libpeas-1.0 \
                   libxml-2.0 \
                   pangoft2 && \
    dnf -y install git gcc-c++ gjs gjs-devel libpeas-devel desktop-file-utils \
    openssl-devel python-devel python-pip gcc libffi-devel \
    gtksourceview3-devel libgit2-devel libgit2-glib-devel clang-devel file glibc-common vala-devel vala llvm-devel vte-devel \
    vte291-devel vala-tools redhat-rpm-config sudo; \
    dnf groupinstall -y development-libs development-tools gnome-software-development; \
    git clone https://github.com/bossjones/hacker-shellscripts.git && \
    sed 's,sudo,,g' -i hacker-shellscripts/fedora/jhbuild-sysdeps--install-all.sh && \
    bash hacker-shellscripts/fedora/jhbuild-sysdeps--install.sh && \
    echo "LANG=en_US.UTF-8" > /etc/locale.conf && \
    echo "LC_ALL=en_US.UTF-8" >> /etc/locale.conf && \
    dnf install langpacks-en.noarch utf8proc.x86_64 glibc-all-langpacks utf8proc.x86_64 glibc-locale-source perl-Unicode-CheckUTF8.x86_64 -y && \
    localedef -v -c -i en_US -f UTF-8 en_US.UTF-8; \
    pip install --upgrade pip; \
    pip install pyopenssl ndg-httpsclient pyasn1 && \
    rm -rf ~/.pip; \
    dnf clean all;
    
    
    RUN git clone git://git.gnome.org/gnome-builder && \
        cd gnome-builder && \
        ./autogen.sh --prefix=/usr/ --enable-clang-plugin=yes --enable-terminal-plugin=yes \
        --enable-vala-pack-plugin=yes --enable-xml-pack-plugin=yes --enable-html-preview-plugin=yes \
        --enable-html-completion-plugin=yes --enable-introspection=yes --enable-autotools-plugin=yes \
        --enable-symbol-tree-plugin=yes --enable-python-pack-plugin && \
        make -j1 && \
        make install; echo "[Might have to rebuild]"

    # # Drop suid
    # RUN find / -xdev -perm /6000 -type f -print0 | xargs -0 chmod -6000

    # ############################################
    # # 
    # ############################################
    # echo "LANG=en_US.UTF-8" > /etc/locale.conf
    # echo "LC_ALL=en_US.UTF-8" >> /etc/locale.conf
    
    # export LANG=en_US.UTF-8
    # dnf install langpacks-en.noarch utf8proc.x86_64 -y
    # dnf install glibc-all-langpacks -y 
    # localedef -v -c -i en_US -f UTF-8 en_US.UTF-8
    
    # ############################################
    
    # history just in case:
    
    # [root@b785605418eb /]# history
    #     1  dnf update -y
    #     2  dnf search langpacks-hi
    #     3  dnf search langpacks
    #     4  dnf search langpacks | grep us
    #     5  clear
    #     6  dnf search langpacks | grep en
    #     7  clear
    #     8  dnf install langpacks-en.noarch -y
    #     9  clear
    #    10  echo "LANG=en_US.UTF-8" >> /etc/locale.conf
    #    11  echo "LC_ALL=en_US.UTF-8" >> /etc/locale.conf
    #    12  localedef -i en_US -f UTF-8 en_US.UTF-8
    #    13  dnf search utf-8
    #    14  clear
    #    15  dnf install langpacks-en.noarch utf8proc.x86_64 -y
    #    16  clear
    #    17  localedef -i en_US -f UTF-8 en_US.UTF-8
    #    18  dnf search utf-8
    #    19  dnf install utf8proc.x86_64 perl-Unicode-CheckUTF8.x86_64
    #    20  clear
    #    21  localedef -i en_US -f UTF-8 en_US.UTF-8
    #    22  dnf install glibc-locale-source
    #    23  dnf install glibc-all-langpacks
    #    24  dnf search glibc-langpack
    #    25  dnf search glibc-langpack-en
    #    26  dnf install glibc-langpack-en -y
    #    27  export LANG=en_US.UTF-8
    #    28  localectl set-locale LANG=en_US.UTF-8
    #    29  vim /etc/locale.conf
    #    30  cat /etc/locale.conf
    #    31  dnf install vim -y
    #    32  vim /etc/locale.conf
    #    33  localectl set-locale LANG=en_US.UTF-8
    #    34  vim /etc/locale.conf
    #    35  localectl set-locale LANG=en_US.UTF-8
    #    36  vim /etc/locale.conf
    #    37  locale
    #    38  localedef
    #    39  localedef -v -c -i en_US -f UTF-8 en_US.UTF-8
    #    40  clear
    #    41  history
    # [root@b785605418eb /]#

RUN useradd -m -d /home/developer developer

# USER developer

# ENTRYPOINT ["/usr/bin/gnome-builder"]
