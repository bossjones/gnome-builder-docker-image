FROM fedora:rawhide

MAINTAINER Leandro Santiago <leandrosansilva@gmail.com>

RUN yum -y update && yum -y install git gcc-c++ gjs gjs-devel libpeas-devel \
    gtksourceview3-devel libgit2-devel libgit2-glib-devel clang-devel file vala-devel vala llvm-devel vte-devel \
    vte291-devel vala-tools redhat-rpm-config; \
    yum groupinstall -y development-libs development-tools gnome-software-development; \
    yum clean all; git clone git://git.gnome.org/gnome-builder && \
    cd gnome-builder && \
    ./autogen.sh --prefix=/usr/ --enable-clang-plugin=yes --enable-terminal-plugin=yes \
    --enable-vala-pack-plugin=yes --enable-xml-pack-plugin=yes --enable-html-preview-plugin=yes \
    --enable-html-completion-plugin=yes --enable-introspection=yes --enable-autotools-plugin=yes \
    --enable-symbol-tree-plugin=yes && \
    make -j1 && \
    make install

RUN useradd -m -d /home/developer developer

USER developer

ENTRYPOINT ["/usr/bin/gnome-builder"]
