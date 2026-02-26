#!/bin/bash
set -e

UNAME=${UNAME:-adv}
HOST_UID=${HOST_UID:-1000}
HOST_GID=${HOST_GID:-1000}

if [ "$HOST_UID" -lt 1000 ] || [ "$HOST_UID" -eq "65534" ]; then
    echo "WARNING: HOST_UID=$HOST_UID is a system UID, falling back to adv (1000:1000)"
    UNAME="adv"
    HOST_UID=1000
    HOST_GID=1000
fi

if ! getent group "$HOST_GID" >/dev/null && ! getent group "$UNAME" >/dev/null; then
    groupadd -g "$HOST_GID" "$UNAME"
fi

if ! id -u "$UNAME" >/dev/null 2>&1; then
    useradd -M -d "/home/$UNAME" -u "$HOST_UID" -g "$HOST_GID" -s /bin/bash -G sudo "$UNAME"
    echo "$UNAME:ajLGz61mdCP76" | chpasswd -e
fi

if ! grep -q "^$UNAME " /etc/sudoers; then
    echo "$UNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
fi

export HOME="/home/$UNAME"
export USER="$UNAME"
export HEXAGON_ROOT="$HOME/Qualcomm/HEXAGON_Tools"
export PATH="$HOME/bin:${PATH}"

if [ ! -f "$HOME/bin/repo" ]; then
    mkdir -p "$HOME/bin"
    curl https://raw.githubusercontent.com/GerritCodeReview/git-repo/v2.41/repo -o "$HOME/bin/repo"
    chmod a+x "$HOME/bin/repo"
    chown -R "$HOST_UID:$HOST_GID" "$HOME/bin"
    sed -i 's/#!\/usr\/bin\/env python/#!\/usr\/bin\/env python3/' "$HOME/bin/repo"
fi

INITIALIZED_FLAG="$HOME_DIR/.dev_env_initialized"

if [ ! -f "$INITIALIZED_FLAG" ]; then
    echo "First time setup for user $UNAME..."

    cp -r -n /etc/skel/. $HOME

    chown "$HOST_UID:$HOST_GID" "/home/$UNAME/".*

    cat <<EOF >> "$HOME/.bashrc"

export HOME="/home/$UNAME"
export USER="$UNAME"
export HEXAGON_ROOT="$HOME/Qualcomm/HEXAGON_Tools"
export PATH="$HOME/bin:$PATH"
EOF

    cat <<'EOF' >> "$HOME/.bashrc"

make() {
    local target=${1:-all}
    local logdir="$(pwd)/log"
    [ -d "$logdir" ] || mkdir -p "$logdir"
    local logfile="$logdir/$(date +%Y%m%d%H%M%S)_${target}.log"
    command make "$@" 2>&1 | tee "$logfile"
}
EOF

    gosu "$UNAME" git config --global user.email "you@example.com"
    gosu "$UNAME" git config --global user.name "Your Name"
    gosu "$UNAME" git config --global color.ui auto
    gosu "$UNAME" git config --global http.postBuffer 1048576000
    gosu "$UNAME" git config --global http.maxRequestBuffer 1048576000
    gosu "$UNAME" git config --global http.lowSpeedLimit 0
    gosu "$UNAME" git config --global http.lowSpeedTime 999999
    gosu "$UNAME" git config --global http.https://chipmaster2.qti.qualcomm.com.followRedirects true
    gosu "$UNAME" git config --global http.https://qpm-git.qualcomm.com.followRedirects true

    if [ ! -f "$HOME_DIR/bin/repo" ]; then
        mkdir -p "$HOME_DIR/bin"
        curl -s https://raw.githubusercontent.com/GerritCodeReview/git-repo/v2.41/repo -o "$HOME/bin/repo"
        chmod a+x "$HOME/bin/repo"
        sed -i 's/#!/usr/bin/env python/#!/usr/bin/env python3/' "$HOME/bin/repo"
    fi

    touch "$INITIALIZED_FLAG"
    chown "$HOST_UID:$HOST_GID" "$INITIALIZED_FLAG"
fi

cd $HOME
exec gosu "$UNAME" "$@"
