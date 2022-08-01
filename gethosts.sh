#!/usr/bin/bash
# MIT License
# @Agni Datta 2022
# This script downlaods the latest Steven Black hosts file from Github Mirror.
# There is a backup and move component which moves the downlaoded hosts file to /etc/hosts
# Script shall be stored in /etc/init.d/gethosts.sh
# To enable it at boot use the following:
# chmod +x /etc/init.d/gethosts.sh; ln -s /etc/init.d/gethosts.sh /etc/rc.d/;

while true; do
  curl https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts -o /tmp/hosts | grep "HasErrors.:true"
  sudo mv /etc/hosts /etc/hosts.old
  sudo cp /tmp/hosts /etc/hosts | grep "HasErrors.:true"
  echo "Script ran sucessfully at " date "!" >>"customhostslogfile.$(date +'%Y-%m-%d').log"
  if [[ "$?" -ne 0 ]]; then
    break
  fi
  sleep 120
done
