FROM    alpine:edge

RUN     apk -U add alpine-sdk

RUN     mkdir -p /var/cache/distfiles && \
        adduser -D packager && \
        addgroup packager abuild && \
        chgrp abuild /var/cache/distfiles && \
        chmod g+w /var/cache/distfiles && \
        echo "packager    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# you should drop your own .abuild directory in the main directory
# the pub key goes into the trusted key directory 
COPY .abuild/*.rsa.pub /etc/apk/keys
COPY --chown=packager:packager .abuild /home/packager/.abuild

RUN mkdir /work && \
    chown -R packager:packager /work

WORKDIR /work
USER    packager

# optional if you have local fork you won't need this - see run.sh to mount volume
RUN cd /work && \
    git clone https://github.com/alpinelinux/aports.git
