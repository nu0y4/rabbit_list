#!/bin/bash
curl -s -m 5 --retry 1024 "https://www.lintcode.com/new/api/accounts/$1/profile/" -o lintcode
cat lintcode | sed -e 's/,/ /g' -e 's/""/unkonwn/g' -e 's/"//g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -E '^email|^first_name|^is_staff|^is_new_user|^id|^last_name|^nickname|^description|^dream|^facebook|github"|^google|^jiuzhang|^linkedin_oauth2|^weixin' | sed -e 's/^/# /g' -e 's/}//g'
rm -f lintcode
