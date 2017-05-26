Gnome Builder (from master branch) Image based on Fedora Rawhide

# What do I need?
- local ip address
    - How do I get it?
        - `ifconfig en0 | grep "inet "| awk '{print $2}'`
            or 
        - `npm install -g my-local-ip`
- socat
    - How do I get it?
        - `brew install socat`
        - `<package-manager> install socat`
- XQuartz
    - How do I get it?
        - `brew cask install xquartz`

# Helpful aliases

```
alias docker_x11_socat='socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"'
alias docker_x11_jess_geary='docker run --rm --name geary -e DISPLAY=`ifconfig en0 | grep "inet "  | cut -d" " -f2`:0 jess/geary'
alias my_ip='ifconfig en0 | grep "inet "  | cut -d" " -f2'
alias docker_eclipse='docker run -it -e DISPLAY=`ifconfig en0 | grep "inet "  | cut -d" " -f2`:0 batmat/docker-eclipse'
alias docker_xquartz='open -a XQuartz'
```

# Prereq
    - Start Up socat: `alias docker_x11_socat='socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"'`


I am not a GNOME developer, but found no easy way to try Builder on my machine.
So I decided to create this image. Simple like this.

To execute it:

$ docker run --rm -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix leandrosansilva/gnome-builder


$ MY_IP=$(ifconfig en0 | grep "inet "| awk '{print $2}') \
  docker run --rm -e DISPLAY=$MY_IP:0 \
  -i -t \
  bossjones/gnome-builder-docker-image bash

MY_IP=$(ifconfig en0 | grep "inet "| awk '{print $2}') \
  docker run --rm -e DISPLAY=192.168.0.3:0 \
  -i -t \
  -v /Users/timlinux:/home/timlinux \
    kartoza/qgis-desktop qgis

# docker run --rm -it -e DISPLAY=192.168.1.129:0

# docker build -t kartoza/qgis-desktop git://github.com/kartoza/docker-qgis-desktop

# docker build -t bossjones/gnome-builder .

PS: This image is ***huge***, about 2GB in size.
