#!/bin/bash
function dir_test()
{
    dir=$(ls bak | grep '^log$')
    test_dir=${#dir}
    if [ $test_dir != 0 ]
    then 
    content=$(head -n 1 ./bak/log)
    lenth=${#content}
    if [ $lenth != 0 ]
    then  
    echo '# 搜索结果 '
    else 
    echo "# 未记录任何数据"
    exit
    fi 
    else 
    echo "# 文件丢失"
    exit
    fi 
}  
dir_test
all_words=$(echo "$1" | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | xargs)
echo -n "cat ./bak/log" > 1.sh
for words in $all_words
do
echo -n "| grep $words" >> 1.sh
done 
echo -n "| sort | uniq" >> 1.sh
sh ./1.sh > result
line=$(cat result | wc | awk '{print $1}')
echo "总计 $line 行"
result=$(cat ./result)
if [ $line == 1 ]
then 
email=$(echo "$result" | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -i 'email' | sed -e 's/:/ /g' | awk '{print $2}')
registrationtime=$(echo "$result" | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -i '注册时间' | sed -e 's/:/ /g' | awk '{print $2}')
location=$(echo "$result" | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -i '属地' | sed -e 's/:/ /g' | awk '{print $2}')
ip=$(echo "$result" | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -i 'ip:' | sed -e 's/:/ /g' | awk '{print $2}')
nickname=$(echo "$result" | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep 'nickname' | sed -e 's/:/ /g' | awk '{print $2}')
username=$(echo "$result" | sed -e 's/username:/ username:/g' -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep 'username' | sed -e 's/:/ /g' | awk '{print $2}' )
gender=$(echo "$result" | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep '性别' | sed -e 's/:/ /g' | awk '{print $2}')
echo "#####################"
echo "# username=$username"
echo "# nickname=$nickname"
echo "# gender=$gender"
echo "# ip=$ip"
echo "# 粗略位置=$location"
echo "# 注册时间=$registrationtime "
echo "# email=$email"
echo "#####################"
echo "username=$username"  > userinfo.bak
echo "nickname=$nickname" >> userinfo.bak
echo "gender=$gender" >> userinfo.bak
echo "ip=$ip" >> userinfo.bak
echo "粗略位置=$location" >> userinfo.bak
echo "注册时间=$registrationtime " >> userinfo.bak
echo "email=$email" >> userinfo.bak
else 
echo "$result" | sed -e 's/^/# /g'
fi 
rm 1.sh
rm result

