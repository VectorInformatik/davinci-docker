# ubuntu-base
FROM ubuntu:24.04
ARG TZ=Europe/Berlin

# Set up timezone and certificates
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    gnupg \
    tzdata \
    curl \
    wget \
    iproute2 \
    sudo \
    ca-certificates \
    && update-ca-certificates \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/* \
    && rm -rf /var/log/*

# Add vector external package sources
RUN wget -O - https://packages.vehub.vector.com/apt/vector-pkg.key | gpg --dearmor -o /usr/share/keyrings/vector-pkg.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/vector-pkg.gpg] https://packages.vehub.vector.com/apt generic main" >> /etc/apt/sources.list.d/vector.list \
    && echo "deb [signed-by=/usr/share/keyrings/vector-pkg.gpg] https://packages.vehub.vector.com/apt focal main" >> /etc/apt/sources.list.d/vector.list

# Install packages
RUN apt-get update \
    && apt-get install -y \
    openjdk-11-jdk \
    openjdk-17-jre-headless \
    vector-license-client \
    # Tool itself
    vector-davinci-developer-classic-cli-4.15.53 \
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/* \
    && rm -rf /var/log/*

COPY ./vector-license-setup.sh /usr/bin/vector-license-setup
RUN chmod +x /usr/bin/vector-license-setup

# Create working directory and add vector user
RUN mkdir -p /work \
    # Create ssh dir for the root user
    && mkdir -p /root/.ssh \
    # Create a default user
    && usermod --login vector --move-home --home /home/vector ubuntu \
    # Allow usage of sudo without password
    && echo "vector ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vector_all

# to ensure proper UTF-8 encoding support for proper string handling (needed in python, devcontainer, ...)
ENV LC_ALL="C.UTF-8" \
    LANG="C.UTF-8"

# Entry point
WORKDIR /work
