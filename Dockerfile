############################################################
# Dockerfile that builds a GarrysMod Gameserver
############################################################
FROM centos:8
LABEL maintainer="martin@sirscythe.net"

ENV APPDIR=/home/steam/gmod-dedicated STEAMCMDDIR=/home/steam/steamcmd

## Install libncursesw5
USER root
RUN useradd -m steam && \
    yum install -y glibc.i686 libstdc++.i686 ncurses-libs.i686 && \
    yum clean all -y && \
    rm -rf /var/cache/yum

# Run Steamcmd and install Gmod
USER steam
RUN mkdir $STEAMCMDDIR && \
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - -C $STEAMCMDDIR && \
    $STEAMCMDDIR/steamcmd.sh +login anonymous \
        +force_install_dir $APPDIR \
        +app_update 4020 validate \
        +quit

ENV MAP=gm_construct \
    EXTRAARGS=""

WORKDIR $APPDIR

VOLUME $APPDIR

# Set Entrypoint; Technically 2 steps: 1. Update server, 2. Start server
CMD $STEAMCMDDIR/steamcmd.sh +login anonymous +force_install_dir $APPDIR +app_update 4020 +quit && \
    $APPDIR/srcds_run -game garrysmod +map $MAP $EXTRAARGS

# Expose ports
EXPOSE 27015/udp 27005
