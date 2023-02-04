#!/bin/bash
curl -s -H 'Host: www.freebuf.com' -H 'User-Agent: Mozilla/5.0 (X11; CrOS x86_64 14794.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5045.0 Safari/537.36' "https://www.freebuf.com/author/$1" -o ./freebuf
cat ./freebuf | grep 'data:\[{' | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -E -i 'nickname|user_registered|description|rmb|jb'
rm -f ./freebuf
