#!/usr/bin/env bash

DATE=`date +%Y-%m-%d`

pushd ~/git/vimwiki

git add .
git commit -m "vimwiki autocommit for $DATE"
git push

# restore working dir
popd

