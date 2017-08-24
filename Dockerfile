FROM debian:buster-slim

RUN apt update && apt install -y libxml2-utils jq devscripts && rm -rf /var/lib/apt/lists/*

COPY assets /opt/resource/
RUN chmod +x /opt/resource/in && chmod +x /opt/resource/check
