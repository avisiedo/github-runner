# Build hadolint
# https://github.com/hadolint/hadolint/blob/master/docker/Dockerfile
FROM debian:stretch-slim AS builder

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
 && apt-get install --no-install-recommends -y \
    build-essential=12.3 \
    libffi-dev=3.2.* \
    libgmp-dev=2:6.1.* \
    zlib1g-dev=1:1.2.* \
    curl=7.52.* \
    ca-certificates=* \
    git=1:2.11.* \
    netbase=5.4 \
 && curl -sSL https://get.haskellstack.org/ | sh \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN git clone --recursive -b master --depth 1 https://github.com/hadolint/hadolint.git hadolint

WORKDIR /opt/hadolint
RUN stack --no-terminal --install-ghc test --only-dependencies \
    && scripts/fetch_version.sh \
    && stack install --ghc-options="-fPIC" --flag hadolint:static

# COMPRESS WITH UPX
RUN curl -sSL https://github.com/upx/upx/releases/download/v3.94/upx-3.94-amd64_linux.tar.xz \
  | tar -x --xz --strip-components 1 upx-3.94-amd64_linux/upx \
  && ./upx --best --ultra-brute /root/.local/bin/hadolint


#
# Prepare github-runner
#
FROM fedora:31

ARG URL
ARG TOKEN
ARG LABELS=container,amd64,fedora31

# Copy hadolint from builder container
COPY --from=builder /root/.local/bin/hadolint /usr/bin/

# Install linters: pylint, shellcheck, rpmlint
RUN dnf install -y Shellcheck pythin-pip rpmlint \
    && pip install -U pip \
    && pip install pylint \
    && dnf clean all

# Install and register github-runner
WORKDIR /actions-runner
RUN curl -O -L https://github.com/actions/runner/releases/download/v2.262.1/actions-runner-linux-x64-2.262.1.tar.gz \
    && tar xzf actions-runner-linux-x64-2.262.1.tar.gz \
    && rm -vf actions-runner-linux-x64-2.262.1.tar.gz \
    && ./bin/installdependencies.sh \
    && RUNNER_ALLOW_RUNASROOT=1 ./config.sh --unattended --url "$URL" --token "$TOKEN" --labels "$LABELS"

CMD ./run.sh

# Build with
# podman build --build-arg URL=https://github.com/myuser/myproject --build-arg TOKEN=my_token -t github-runner:fedora31

# Run with
# podman run sssd-github-runner:fedora31

