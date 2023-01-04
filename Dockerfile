FROM ubuntu:latest

RUN apt-get update && \
  apt-get install -yq tzdata && \
  ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime && \
  dpkg-reconfigure -f noninteractive tzdata \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get autoremove -y \
  && apt-get autoclean
ENV TZ="America/Chicago"


RUN apt-get update && apt-get full-upgrade \
  && apt-get install -y \
  fonts-dejavu \
  qtwayland5 \
  qutebrowser \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get autoremove -y \
  && apt-get autoclean

RUN groupadd qb \
  && useradd -g qb -m -d /home/qb qb


USER qb
WORKDIR /home/qb
ENV QT_QPA_PLATFORM=wayland
ENV QT_WAYLAND_DISABLE_WINDOWDECORATION=1
ENTRYPOINT [ "qutebrowser" ]
