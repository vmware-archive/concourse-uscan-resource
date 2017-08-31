FROM debian:buster-slim

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update \
  && apt -y full-upgrade \
  && apt -y install libxml2-utils jq devscripts python3-pip \
  && apt -y autoremove \
  && apt -y autoclean \
  && rm -rf /var/lib/apt/lists/* \
  && pip3 install yq



COPY assets /opt/resource/

RUN chmod +x /opt/resource/in \
  && chmod +x /opt/resource/check
