FROM debian:buster-slim

ARG DEBIAN_FRONTEND=noninteractive
ARG APT_CONF_NOBLOAT='/etc/apt/apt.conf.d/01nobloat'

RUN apt update \
  && { \
    echo 'APT::Install-Recommends "0";' ; \
    echo 'APT::Install-Suggests "0";' ; \
  } > "$APT_CONF_NOBLOAT" \
  && apt -y full-upgrade \
  && apt -y install libxml2-utils jq devscripts \
  && apt -y autoremove \
  && apt -y autoclean \
  && rm -rf /var/lib/apt/lists/* "$APT_CONF_NOBLOAT"

COPY assets /opt/resource/

RUN chmod +x /opt/resource/in \
  && chmod +x /opt/resource/check
