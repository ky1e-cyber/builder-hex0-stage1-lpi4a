#!/bin/sh

(xxd -p $1 | tr -d '\n' | fold -w8 | sed 's/\(..\)\(..\)\(..\)\(..\)/\4 \3 \2 \1/' | tr '[a-f]' '[A-F]' && echo) > $2

