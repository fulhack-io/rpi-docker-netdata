FROM container4armhf/armhf-alpine
#
# Install dependencies
#
RUN apk update
RUN apk add ca-certificates \
  && update-ca-certificates
RUN apk add bash autoconf gcc pkgconfig util-linux-dev zlib-dev libtool automake g++ make libuuid

#
# Install netdata
#
RUN wget https://github.com/firehol/netdata/archive/master.zip -P /tmp \
  && cd /tmp/ \
  && unzip master.zip \
  && cd netdata-master \
  && ./netdata-installer.sh --dont-start-it \
  && cd .. && rm -rf master.zip ndetdata-master

RUN addgroup netdata \
  && adduser -D -G netdata netdata


#
# Cleanup
#
RUN apk del pkgconfig util-linux-dev zlib-dev libtool
RUN rm -rf /var/cache/apk/*

EXPOSE 19999

ENTRYPOINT ['/usr/sbin/netdata']
CMD ["-D"]

