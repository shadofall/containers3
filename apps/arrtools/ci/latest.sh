#!/usr/bin/env bash
version=$(curl -sX GET https://api.github.com/repos/sureshfizzy/CineSync/releases/latest --header "Authorization: Bearer ${TOKEN}" | jq --raw-output '. | .tag_name')
version="${version#*CineSync-}"
printf "%s" "${version}"    

