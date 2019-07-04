FROM gcc:9
LABEL author "Waqqas Jabbar <waqqas.jabbar@gmail.com>"

RUN apt-get clean && apt-get update

RUN apt-get -y install sudo

#install Yocto pre-requisites
RUN apt-get install -y chrpath cpio diffstat gawk texinfo

# create user to run Yocto builds (builder)
RUN groupadd -r builder -g 1000 && \
   useradd -u 1000 -r -g builder -m -d /home/builder -s /bin/bash -c "Builder" builder &&  \
   chmod 755 /home/builder

RUN echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Set the locale
RUN apt-get install -y locales
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 LANGUAGE=en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# Specify the user to execute all commands below
USER builder

## Build poky volume
RUN sudo mkdir /poky
RUN sudo chown -R builder:builder /poky
RUN git clone git://git.yoctoproject.org/poky
RUN cd /poky && git fetch --tags
RUN cd /poky && git checkout tags/yocto-2.7 -b my-yocto-2.7
VOLUME [ "/poky" ]

WORKDIR /poky
