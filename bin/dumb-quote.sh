#!/usr/bin/env bash

cat - |
    sed -e "s/‘/'/g" | \
    sed -e "s/’/'/g" | \
    sed -e "s/…/.../g" | \
    sed -e "s/“/\"/g" | \
    sed -e "s/”/\"/g" 

