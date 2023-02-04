#!/bin/bash
# 
# 简易的 github 爬取
#
#
function getconfig()
{
cat ./config | grep -v '^#' | grep "$1" | sed -e 's/=/ /g' | awk '{print $2}'
}
github_token=$(getconfig github_token)
curl -s -m 10 --retry 1024 "https://api.github.com/users/$1" -A 'Mozilla/5.0' -H "Authorization: token $github_token" -H 'Content-Type:application/json' -H 'method:GET' -H 'Accept:application/json' > ./github
cat ./github | sed -e 's/,/ /g' -e 's/"//g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -E -i 'email|company|twitter_username|create_at|location|blog|name|login|hireable' | sed -e 's/{//g' -e 's/^/# /g'
rm ./github
