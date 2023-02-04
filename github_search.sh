#!/bin/bash
curl -s -m 5 --retry 1024  "https://github.com/search?p=1&q=$1&type=users" -o github_page_$1
cat github_page_$1 | grep 'data-hovercard-url=' | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep 'data-hovercard-url=' | sed -e 's/\// /g' -e 's/"//g' | awk '{print $3}' > github_list
for gituser in $(cat github_list)
do
{ 
./github.sh $gituser
}&
done
wait 
rm -f ./github_page_$1