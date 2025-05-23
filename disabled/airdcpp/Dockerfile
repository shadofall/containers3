FROM ghcr.io/elfhosted/ubuntu:rolling@sha256:2ba3258c7cc40330bfea13a600ca6762591d677db211a3255fbf44d4635481f0 

ARG VERSION

ARG dl_url="https://web-builds.airdcpp.net/stable/airdcpp_${VERSION}_webui-${VERSION}_64-bit_portable.tar.gz"

RUN installDeps=' \
        gnupg \
    ' \
    && runtimeDeps=' \
        ca-certificates \
        locales \
        openssl \
        curl \
    ' \
# Install dependencies
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y --no-install-recommends ${installDeps} ${runtimeDeps} \
# Install node.js to enable airdcpp extension support
    && curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
# Download and install airdcpp
    && echo "Downloading ${dl_url}..." \
    && curl --progress-bar ${dl_url} | tar -xz -C / \
# Cleanup
    && apt-get purge --autoremove -y ${installDeps} \
    && rm -rf /var/lib/apt/lists/*

# Configure locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV PUID 568
ENV GUID 568
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen && dpkg-reconfigure -f noninteractive locales

# Create default directories
RUN mkdir -p /.airdcpp /Downloads /Share \
    # Set permission on default directories
    && chmod a+rwX /.airdcpp /Downloads /Share \
    # Create symlink to configuration directory
    && ln -sf /.airdcpp /airdcpp-webclient/config \
    # Fix /favicon.ico 404 request
    && cd /airdcpp-webclient/web-resources \
    && ln -sf images/favicon.*.ico favicon.ico

RUN ln -sf /airdcpp-webclient/config/ /airdcpp

COPY apps/airdcpp/.airdcpp/ /.default-config
COPY apps/airdcpp/entrypoint.sh /entrypoint.sh
EXPOSE 5600 5601 21248 21249
ENTRYPOINT ["/entrypoint.sh"]
