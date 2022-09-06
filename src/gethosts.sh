#!/usr/bin/bash
# MIT License
# @Agni Datta 2022, @Nadir 2022
# This script downlaods the latest Steven Black hosts file from Github Mirror.
# There is a backup and move component which moves the downlaoded hosts file to /etc/hosts
# Script shall be stored in /etc/init.d/gethosts.sh
# To enable it at boot use the following:
# chmod +x /etc/init.d/gethosts.sh; ln -s /etc/init.d/gethosts.sh /etc/rc.d/;

while true; do
  ping -c 3 google.com
  if [[ "$?" -eq 0 ]]; then
      echo "PING COMPLETED."
      curl https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts -o /tmp/hosts | grep "HasErrors.:true"
      sudo mv /etc/hosts /etc/hosts.old
      sudo cp /tmp/hosts /etc/hosts | grep "HasErrors.:true"
      echo "Script ran sucessfully at " date "!" >> "customhostslogfile.$(date +'%Y-%m-%d').log"
      if [[ "$?" -eq 0 ]]; then
	  echo "SCRIPT RAN"
          sleep 7200	
      fi
  else
      echo "NO INTERNET"
      sleep 120
  fi
done
