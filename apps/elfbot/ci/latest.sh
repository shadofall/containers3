#!/usr/bin/env bash
version=$(curl -sX GET https://api.github.com/repos/funkypenguin/elfbot/releases/latest --header "Authorization: Bearer ${ZURG_GH_CREDS}" | jq --raw-output '. | .tag_name')
printf "%s" "${version}"