#!/bin/bash
curl -s -m 10 --retry 1024 --http2 -H 'Host: github.com' "https://github.com/$1" -o github_profile_$1
cat github_profile_$1 | grep "href=" | grep -E "@|phone|mail" | grep '#' | sed -e 's/</ /g' -e 's/>/ /g' -e 's/"/ /g' -e 's/{/ /g' -e 's/}/ /g' -e 's/\[/ /g' -e 's/\]/ /g' |  awk '{for(i=1;i<=NF;i++){print $i}}' | grep '@' | sed -e 's/^/# /g'
rm -f github_profile_$1