Introduction
----

This project is used to build a custom app using Yocto build system

What does this image provide
---

- A separate container where Yocto is checked out, mapped to directory '/poky'
- Yocto version 2.7 in /poky directory
- A non-root user named 'builder' with sudo access

How to use
---

- Run the container by `./run_docker.sh /bin/bash`
- Inside the container
 - Initialize the Yocto environment `source oe-init-build-env`
 - Run bitbake `bitbake core-image-minimal`
 - Run QEMU emulator `runqemu qemux86`



