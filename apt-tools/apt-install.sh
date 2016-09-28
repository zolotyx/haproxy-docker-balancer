#!/bin/bash

set -e

rm -f /var/log/dpkg.log

apt-get update
apt-get -y --no-install-recommends install "$@"