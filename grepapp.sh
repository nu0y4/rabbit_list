#!/bin/bash
page=1
dir=$(ls | grep 'grep_all')
test_dir=${#dir}
if [ $test_dir != 0 ]
then 
rm ./grep_all 
fi
# echo "# 爬取开始" 
for page in `seq 1 2`
do 
{
# echo "# 第 $page 页"
curl -s -m 10 --retry 1024 "https://grep.app/api/search?q=$1&regexp=true&page=$page" -o ./grep_app_$page
match=$(cat grep_app_$page | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep 'total_matches' | xargs | sed -e 's/ //g')
test_match=${#match}
if [ $test_match == 0 ]
then 
# echo "# 爬取完毕"
rm ./grep_app_$page
break
else
result=$(cat ./grep_app_$page | sed  -e 's/ /++-_-++/g' -e 's/<\/span>/ /g' -e 's/<\/mark>/<\/mark> /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep '<mark>' | sed -e 's/<\/mark>//g' -e 's/<mark>//g') 
# echo "# result=$result"
echo "$result" >> ./grep_all
fi
rm ./grep_app_$page
}
done
