FROM --platform=$TARGETPLATFORM ubuntu:20.04
ARG TARGETPLATFORM
ARG BUILDPLATFORM

LABEL version="1.0" description="ubuntu_symlink" by="dirk@kooiot.com"

ENV SYMLINKPATH /mnt/sympad
WORKDIR $SYMLINKPATH

RUN echo "Build SymLink on $BUILDPLATFORM, building for $TARGETPLATFORM"

RUN mkdir -p /opt/sympad
COPY build/common/* /opt/sympad

RUN mkdir -p /opt/sympad/pkg
RUN mkdir /opt/sympad/pkg/DsDrivers
RUN mkdir /opt/sympad/pkg/IoDrivers
RUN mkdir /opt/sympad/pkg/project

RUN chown -R root:root /opt/sympad

COPY files/$TARGETPLATFORM/* /opt/sympad/pkg

RUN apt update -y \
	&& apt install -y libcurl4 net-tools unzip \
	&& apt clean \
	&& rm -rf /var/lib/apt/list/*
    
EXPOSE 8240/tcp 9200/tcp 9230/tcp 9231/tcp 2404/tcp 1996/udp 2000/udp 2005/udp 2008/udp

CMD ["/opt/sympad/docker-entrypoint.sh"]
