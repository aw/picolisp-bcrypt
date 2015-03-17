#!/bin/sh
#
# Copyright (c) 2015 Alexander Williams, Unscramble <license@unscramble.jp>
# MIT License

set -u
set -e

git submodule init
git submodule update

cd vendor/bcrypt
  gcc -O2 -g -I. -Icrypt_blowfish/ -fPIC -shared -Wl,-soname,libbcrypt.so -o libbcrypt.so bcrypt.c crypt_blowfish/crypt_blowfish.c crypt_blowfish/crypt_gensalt.c crypt_blowfish/wrapper.c
cd -

cd lib
  rm -f libbcrypt.so
  ln -s ../vendor/bcrypt/libbcrypt.so libbcrypt.so
cd -
