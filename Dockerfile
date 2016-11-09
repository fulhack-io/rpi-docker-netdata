FROM hypriot/rpi-alpine-scratch:v3.4
#
# Install
#
RUN apk add --no-cache bash autoconf gcc pkgconfig util-linux-dev zlib-dev libtool automake g++ make libuuid wget ca-certificates --no-cache \
  && update-ca-certificates \
  && wget https://github.com/firehol/netdata/archive/master.zip -P /tmp \
  && cd /tmp/ \
  && unzip master.zip \
  && cd netdata-master \
  && ./netdata-installer.sh --dont-start-it \
  && cd .. && rm -rf master.zip ndetdata-master \
  && addgroup netdata \
  && adduser -D -G netdata netdata \
  && apk del pkgconfig util-linux-dev zlib-dev libtool \
  && rm -rf /var/cache/apk/*

EXPOSE 19999

ENTRYPOINT ['/usr/sbin/netdata']
CMD ["-D"]

