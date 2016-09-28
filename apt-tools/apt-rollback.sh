#!/bin/bash

set -e

awk '$3~/^install$/ {print $4;}' /var/log/dpkg.log | \
    xargs apt-get -y remove --purge --auto-remove

apt-commit