#!/usr/bin/env bash

cd ~

#create repo dir
mkdir -p repo

#generate ssh-key
cat /dev/zero | ssh-keygen -q -N ""

cd -