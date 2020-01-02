#!/usr/bin/env bash

# This script filters stdin and replaces a large number of "smart" typographic
# characters with dumb, plain ASCII equivalents. Some of these characters are
# non-printable, so edit carefully.
#
# The goal of the script is to make it easy to turn content pasted from
# programs like Word into programs that can't handle the extended characters.

cat - |
    sed -e "s/‘/'/g" | \
    sed -e "s/’/'/g" | \
    sed -e "s/…/.../g" | \
    sed -e "s/“/\"/g" | \
    sed -e "s/”/\"/g" | \
    sed -e "s//-/g" | \
    sed -e "s/ / /g"

