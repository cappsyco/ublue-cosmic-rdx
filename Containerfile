FROM scratch as ctx

COPY system_files /files
COPY build_scripts /build_scripts

FROM quay.io/fedora-ostree-desktops/cosmic-atomic:42

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build_scripts/build.sh && \
    ostree container commit
