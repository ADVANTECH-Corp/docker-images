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
fi

if ! grep -q "^$UNAME " /etc/sudoers; then
    echo "$UNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
fi

INITIALIZED_FLAG="/.dev_env_initialized"

if [ ! -f "$INITIALIZED_FLAG" ]; then
    echo "First time setup for user $UNAME..."
    cp -r --update=none /etc/skel/. "/home/$UNAME"/

    BASHRC="/home/$UNAME/.bashrc"
    echo "export HOME=/home/$UNAME" >> "$BASHRC"
    echo "export USER=$UNAME" >> "$BASHRC"

    chown "$HOST_UID:$HOST_GID" "/home/$UNAME"
    chown "$HOST_UID:$HOST_GID" "/home/$UNAME/".*

    touch "$INITIALIZED_FLAG"
fi

export HOME=/home/$UNAME
export USER=$UNAME

cd $HOME
exec gosu "$UNAME" "$@"
