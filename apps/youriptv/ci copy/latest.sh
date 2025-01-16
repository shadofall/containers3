#!/usr/bin/env bash

version=$(curl -sX GET "https://api.github.com/repos/mikmc55/epgtv/commits/main" --header "Authorization: Bearer ${TOKEN}" | jq --raw-output '.sha')
printf "%s" "${version}"
