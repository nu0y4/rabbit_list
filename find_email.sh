#!/bin/bash
function rmfiles()
{
for file in $(ls | grep 'grep_app_')
do 
rm $file
done
}
./grepapp.sh $1 > /dev/null
wait
dir=$(ls | grep 'grep_all')
test_dir=${#dir}
if [ $test_dir == 0 ]
then 
echo "# 没有找到 $1 相关的代码仓库邮箱泄漏"
else 
mail_list=$(cat ./grep_all | sed -e 's/。/ /g' -e 's/,/ /g' -e 's/\u/ /g' -e 's/;/ /g' -e 's/"/ /g' -e 's/>/ /g' -e 's/</ /g' -e 's/:/ /g' -e 's/：/ /g' -e 's/?/ /g' -e 's/？/ /g' -e 's/\[/ /g' -e 's/\]/ /g' -e 's/{/ /g' -e 's/}/ /g' -e 's/\$/ /g' -e 's/\^/ /g' -e 's/#/ /g' -e 's/++-_-++/ /g' -e 's/\\/ /g' -e 's/\// /g'  -e 's/）/ /g' -e 's/（/ /g' -e 's/(/ /g' -e 's/)/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep "@"  | grep -v '^@' | grep -v '@$' | grep -E '[a-z]|[A-Z]' | grep '\.' | grep -v -E '\?|\？|\\|\/|\*|\$|\^|%|&|#' )
test_mail_list=${#mail_list}
if [ $test_mail_list != 0 ]
then 
echo "$mail_list" | sort | uniq
else 
echo "# null"
fi 
fi 