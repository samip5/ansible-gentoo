#!/bin/bash
install_path="/mnt/gentoo"
latest="latest-stage3-amd64.txt"
mirror="{{ mirror }}"
latest_uri="{{ mirror }}/releases/amd64/autobuilds/$latest"

if [ ! -f "$install_path/$latest_uri" ]
then
  curl -sO $latest_uri
fi

if [ -z "$SHOW_RELEASE_NAME" ]
then
  stage3_path=$(cat $install_path/$latest | awk '/stage3-amd64-[0-9TZ]+\.tar\.xz/ { print $1 }')
  curl -sO  "$mirror/releases/amd64/autobuilds/$stage3_path"
  curl -sO  "$mirror/releases/amd64/autobuilds/$stage3_path.DIGESTS.asc"
  awk 'f{print $1, $2;f=0;exit}/SHA512/{f=1}' *.DIGESTS.asc > stage3.sha512
else
  cat $install_path/$latest | awk -F'/' '/stage3-amd64-[0-9TZ]+\.tar\.xz/ { print $1 }'
fi