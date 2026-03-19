#!/usr/bin/env bash

# Start DBus
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

# Start fresh Emacs (NO daemon for now)
exec emacs
