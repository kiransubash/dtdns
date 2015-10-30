#!/bin/bash

# Your hostname goes here
id="myhostnamehere"

# Your password goes here
password="secret"

currentIP=`dig +short ${id}`
myIP=`dig +short myip.opendns.com @resolver1.opendns.com`
if [[ -z ${currentIP} || -z ${myIP} ]]; then
  echo "Couldn't lookup succesfully, try later"
  exit 127
else
  if [[ "${currentIP}" != "${myIP}" ]]; then
    echo -e "GET /api/autodns.cfm?id=${id}&pw=${password}&client=Linux HTTP/1.1\nHost: www.dtdns.com\nUser-Agent: bash\n\n" | nc www.dtdns.com 80 
  else
    echo "No need to update"
  fi
fi 
exit 0
