--viccm模板
FROM i386/ubuntu:latest
LABEL version="1.0" description="i386_ubuntu_symlink" by="viccom"
ENV SYMLINKPATH /mnt/sympad
WORKDIR $SYMLINKPATH
RUN apt update \
	&& apt install wget -y \
	&& apt install unzip -y \
	&& rm -rf /var/lib/apt/lists/* \
    && wget -O /tmp/symlink.tar.gz "https://symtech.oss-cn-beijing.aliyuncs.com/symlink/linux_x86/symlink.tar.gz" \
    && tar -zxvf /tmp/symlink.tar.gz -C / \
    && mkdir -p /mnt/sympad/data/ \
    && touch /mnt/sympad/data/appversion.xml \
    && mv /mnt/sympad/DsDrivers /mnt/sympad/data/ \
    && mv /mnt/sympad/IoDrivers /mnt/sympad/data/ \
    && mv /mnt/sympad/project /mnt/sympad/data/ \
    && ln -s /mnt/sympad/data/DsDrivers /mnt/sympad/DsDrivers \
    && ln -s /mnt/sympad/data/IoDrivers /mnt/sympad/IoDrivers \
    && ln -s /mnt/sympad/data/project /mnt/sympad/project \
    && ln -s /mnt/sympad/data/appversion.xml /mnt/sympad/appversion.xml \
    && rm -f /tmp/symlink.tar.gz
    
EXPOSE 8240/tcp 9200/tcp 9230/tcp 9231/tcp 2404/tcp 1996/udp 2000/udp 2005/udp 2008/udp

CMD ["/mnt/sympad/symlinkrun.sh"]

--david修改版
FROM i386/ubuntu:latest    --去docker网站上下载这个镜像，这个文件都是基于这个镜像做的
LABEL version="1.0" description="i386_ubuntu_symlink" by="viccom"
ENV SYMLINKPATH /mnt/sympad
WORKDIR /mnt/sympad
COPY sympad.tar.gz /tmp/
RUN apt update \
	&& apt install unzip -y \
	&& rm -rf /var/lib/apt/lists/* \
    && tar -zxvf /tmp/sympad.tar.gz -C /mnt/ \
    && mkdir -p /mnt/sympad/data/ \
    && touch /mnt/sympad/data/appversion.xml \
    && mv /mnt/sympad/DsDrivers /mnt/sympad/data/ \
    && mv /mnt/sympad/IoDrivers /mnt/sympad/data/ \
    && mv /mnt/sympad/project /mnt/sympad/data/ \
    && ln -s /mnt/sympad/data/DsDrivers /mnt/sympad/DsDrivers \
    && ln -s /mnt/sympad/data/IoDrivers /mnt/sympad/IoDrivers \
    && ln -s /mnt/sympad/data/project /mnt/sympad/project \
    && ln -s /mnt/sympad/data/appversion.xml /mnt/sympad/appversion.xml \
    && rm /tmp/sympad.tar.gz

EXPOSE 8240/tcp 9200/tcp 9230/tcp 9231/tcp 2404/tcp 1996/udp 2000/udp 2005/udp 2008/udp

CMD ["/mnt/sympad/symlinkrun.sh"]
