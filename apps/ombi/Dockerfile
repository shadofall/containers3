FROM ghcr.io/elfhosted/ubuntu:rolling@sha256:2ba3258c7cc40330bfea13a600ca6762591d677db211a3255fbf44d4635481f0

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG VERSION
ARG CHANNEL

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2039,SC2086
RUN \
    apt-get -qq update \
    && \
    apt-get -qq install -y \
        libicu66 \
        libssl1.1 \
    && \
    case "${TARGETPLATFORM}" in \
        'linux/amd64') export ARCH='x64' ;; \
        'linux/arm64') export ARCH='arm64' ;; \
    esac \
    && \
    curl -fsSL "https://github.com/Ombi-app/Ombi/releases/download/v${VERSION}/linux-${ARCH}.tar.gz" \
        | tar xzf - -C /app \
    && \
    apt-get autoremove -y \
    && apt-get clean \
    && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/ \
    && chown -R root:root /app \
    && chmod -R 755 /app \
    && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc

USER 568
COPY ./apps/ombi/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/Ombi-app/Ombi"
