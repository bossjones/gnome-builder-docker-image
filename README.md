Gnome Builder (from master branch) Image based on Fedora Rawhide

I am not a GNOME developer, but found no easy way to try Builder on my machine.
So I decided to create this image. Simple like this.

To execute it:

$ docker run --rm -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix leandrosansilva/gnome-builder

PS: This image is ***huge***, about 2GB in size.
