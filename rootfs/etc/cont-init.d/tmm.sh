#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

log() {
    echo "[cont-init.d] $(basename $0): $*"
}

# Make sure mandatory directories exist.
mkdir -p /config/logs

if [ ! -f /config/tmm.jar ] || [ ! -f /config/tmm.tar.xz ] || ! cmp /defaults/tmm.tar.xz /config/tmm.tar.xz; then
    cp -r /defaults/* /config/
    cd /config
    tar --strip-components=1 -xJf /config/tmm.tar.xz
fi

# Take ownership of the config directory content.
# Use default values if USER_ID/GROUP_ID are not set
USER_ID="${USER_ID:-1000}"
GROUP_ID="${GROUP_ID:-1000}"
export USER_ID
export GROUP_ID
chown -R $USER_ID:$GROUP_ID /config/*

# Take ownership of the output directory.
#if ! chown $USER_ID:$GROUP_ID /output; then
    # Failed to take ownership of /output.  This could happen when,
    # for example, the folder is mapped to a network share.
    # Continue if we have write permission, else fail.
#    if s6-setuidgid $USER_ID:$GROUP_ID [ ! -w /output ]; then
#        log "ERROR: Failed to take ownership and no write permission on /output."
#        exit 1
#    fi
#fi

# vim: set ft=sh :
