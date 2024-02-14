FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive \
    TERM=xterm-256color

COPY ./termshark.toml /root/.config/termshark/termshark.toml
COPY ./entrypoint.sh /entrypoint.sh

RUN apt-get update -qq \
  && apt-get install -qqy termshark zsh \
  && rm -rf /var/lib/{apt,dpkg,cache,log}

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "termshark" ]
