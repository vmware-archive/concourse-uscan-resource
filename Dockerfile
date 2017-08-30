FROM debian:buster-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG APT_CONF_NOBLOAT='/etc/apt/apt.conf.d/01nobloat'
ARG APT_ARGS='-y -qq -o=Dpkg::Use-Pty=0'

RUN apt $APT_ARGS update \
  && { \
    echo 'APT::Install-Recommends "0";' ; \
    echo 'APT::Install-Suggests "0";' ; \
  } > "$APT_CONF_NOBLOAT" \
  && apt $APT_ARGS full-upgrade \
  && apt $APT_ARGS install libxml2-utils jq devscripts python3-pip python3-setuptools \
  && pip3 install --no-cache-dir yq \
  && apt $APT_ARGS autoremove \
  && apt $APT_ARGS autoclean \
  && rm -rf /var/lib/apt/lists/* "$APT_CONF_NOBLOAT"

COPY assets /opt/resource/

RUN chmod +x /opt/resource/in \
  && chmod +x /opt/resource/check
