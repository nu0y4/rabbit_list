#!/bin/bash
function getconfig()
{
cat ./config | grep -v '^#' | grep "$1" | sed -e 's/=/ /g' | awk '{print $2}'
}
breach_api=$(getconfig breach_api)
curl -s -m 5 --retry 3 "https://breachdirectory.p.rapidapi.com/?func=auto&term=$1" --header 'X-RapidAPI-Host: breachdirectory.p.rapidapi.com' --header "X-RapidAPI-Key: $breach_api" -o ./breachdirectory
code=$(cat ./breachdirectory | grep '"success": true,') 
test_code=${#code}
if [ $test_code != 0 ]
then 
echo "数据列表"
cat ./breachdirectory | sed -e 's/ //g'  -e 's/"//g' -e 's/,//g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -E '^sha1:|^hash|^password'  
echo "来源: $(cat ./breachdirectory | sed -e 's/ //g'  -e 's/"//g' -e 's/,//g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -v -E '^sha1:|^hash|^password' | grep -v -E '^success|^found|^\}|^\{|^\]|^\[|^result|^has_password|^sources' | sort | uniq | xargs)"
else
echo "null"
fi 
rm ./breachdirectory
