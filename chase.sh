#!/bin/bash
function rmfiles()
{
# 删除无用文件写这里
rm -f  ./userdata ./tmp/userinfo_* 
for files in $(ls | awk '{for(i=1;i<=NF;i++){print $i}}' | grep 'file' | grep -v 'file$')
do 
# echo "# 删除 $files" 
rm -f $files
done 
}
rmfiles
page=1 
time=$(date | sed -e 's/  / /g' -e 's/ /:/g' -e 's/::/:/g' -e 's/日//g' -e 's/年//g' -e 's/月//g' -e 's/星期//g')
function getconfig()
{
cat config | grep -v '^#' | grep "$1" | sed -e 's/=/ /g' | awk '{print $2}'
}
max=$(getconfig search_like_max)
max_page=$(getconfig search_like_page)
# echo "# 最大近似用户名搜索数: $max"
# echo "# 最大近似用户名爬取页数: $max_page"
url="https://so.csdn.net/api/v3/search?q=$1&t=userinfo&p=$page&s=0&tm=0&ft=0&platform=pc" 
function exit_search()
{
query=$1    
curl -s --retry 1024 -m 3 "https://so.csdn.net/api/v3/search?q=$query&t=userinfo&p=1&s=0&tm=0&ft=0&platform=pc" -H "so.csdn.net" -o ./file  
cat file | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep 'total_page' | sed -e 's/"//g' -e 's/:/ /g' -e 's/\./ /g' | awk '{print $2}'
rm -f  file
}
# 初始第一页开始
lastpage=$(exit_search $1)
# echo "# 共 $lastpage 页用户数据"

function dosearch(){
max_page=$1
lastpage=$2
query=$3
echo "# 搜索用户开始"
for page in `seq 1 $lastpage`
do
# echo "# 第 $page 页"
if [ $page == $max_page ]
then
echo "# 达到指定最大爬取页数" 
break
fi 
curl -s --retry 1024 -m 3 "https://so.csdn.net/api/v3/search?q=$query&t=userinfo&p=$page&s=0&tm=0&ft=0&platform=pc" -H "so.csdn.net" -o ./file_$page   
done 
}
function deal()
{
echo "# 数据处理开始"    
for files in $(ls | awk '{for(i=1;i<=NF;i++){print $i}}' | grep 'file' | grep -v 'file$')
do
lenth_file=${#files}
if [ $lenth_file != 0 ]
then 
# echo "# file=$files"
cat $files | sed -e 's/ /++++/g' | sed -e 's/"birthday"/ "birthday"/g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep  'gender' | sed -e 's/++++/ /g' >> userdata
rm -f  $files
else 
# echo "# 删除 无效文件 $files"
rm -f  $files
fi
done 
}
dosearch $max_page $lastpage $1 &
wait
echo "# 数据搜索完成"
deal
function findmore()
{
    null='null'
# echo "# 搜索开始"
    search_id=$1
    lenth=${#search_id}
    if [ $lenth != 0 ]
    then 
    curl -s -m 3 --retry 1024 "https://blog.csdn.net/$1" -o ./tmp/userinfo_$search_id
    file=$(ls ./tmp | grep "userinfo_$search_id")
    lenth_file=${#file}
    if [ $lenth_file == 0 ]
    then 
    echo 'null'
    exit
    else  
    ip=$(cat ./tmp/userinfo_$search_id | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep 'region' | grep 'ip' | sed -e 's/"//g' -e 's/region:{ip://g')
    location=$(cat ./tmp/userinfo_$search_id | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep '属地' | grep -v -E 'msg|span|div' | sed -e 's/：/ /g' -e 's/"//g' | awk '{print $2}')
    regtime=$(cat ./tmp/userinfo_$search_id | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep 'registrationTime' | sed -e 's/"//g' -e 's/registrationTime://g')
    #
    test_ip=${#ip}
    test_regtime=${#regtime}
    if [ $test_ip == 0 ]
    then 
    ip=$(cat ./tmp/userinfo_$search_id  | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}'  | grep 'region' | sed -e 's/:/ /g' | sed -e 's/"//g' | awk '{print $NF}' | grep '[0-9]\.[0-9]')
    fi 
    if [ $test_regtime == 0 ]
    then 
    regtime=$(cat ./tmp/userinfo_$search_id | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}'  | grep 'registration' | sed -e 's/"//g' -e 's/:/ /g' | awk '{print $2}') 
    fi 
    #
    school=$(cat ./tmp/userinfo_$search_id | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep 'school' | sed -e 's/"//g' -e 's/:/ /g' |  awk '{print $2}' | sed -e 's/null/unknown/g')
    company=$(cat ./tmp/userinfo_$search_id | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -i 'company' | grep -v -E -i 'has|module' | sed -e 's/"//g' -e 's/:/ /g' | awk '{print $2}'  | sed -e 's/null/unkonwn/g')
    echo "ip:$ip,属地:$location,注册时间:$regtime,学校:$school,企业:$company"
    rm -f ./tmp/userinfo_$search_id
    fi 
    else
    echo 'null'
    exit
    fi 
}

function searchstart()
{
  echo "# 开始解析 "
  echo "# 共 $allline 行"

for line in `seq 1 $allline`
do 
{
if [ $line == $max ]
then 
echo "# done"
fi
# 
data=$(head -n $line ./userdata | tail -n 1)
search_name=$(echo "$data" | sed -e 's/ /++++/g' | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep 'username' | sed -e 's/"//g' -e 's/:/ /g' | awk '{print $2}' | sed -e 's/++++/ /g')
username=$search_name
#
nickname=$(echo "$data" | sed -e 's/ /+++---/g' | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}'  | grep 'nickname' | sed -e 's/<\/em>//g' -e 's/<em>//g' -e 's/"//g' -e 's/:/ /g' | awk '{print $2}' | sed -e 's/+++---/ /g')
email=$(echo "$data" | sed -e 's/ /+++---/g' | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}'  | grep 'email' | sed -e 's/""/unkonwn/g' -e 's/"//g' -e 's/:/ /g' | awk '{print $2}' | sed -e 's/+++---/ /g')
position=$(echo "$data" | sed -e 's/ /+++---/g' | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}'  | grep 'position' | sed -e 's/""/unkonwn/g' -e 's/"//g' -e 's/:/ /g' | awk '{print $2}' | sed -e 's/+++---/ /g')
gender=$(echo "$data" | sed -e 's/ /+++---/g' | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}'  | grep 'gender' | sed -e 's/""/unkonwn/g' -e 's/"//g' -e 's/:/ /g' | awk '{print $2}' | sed -e 's/+++---/ /g')
#
useful_data="username:$username,nickname:$nickname,email:$email,职位:$position,性别:$gender"
usermore=$(findmore $search_name)
echo "$time:$useful_data,$usermore" >> ./bak/log
} &
done
wait
}

dir_userdata=$(ls | grep 'userdata')
test_dir_userdata=${#dir_userdata}
if [ $test_dir_userdata != 0 ]
then 
allline=$(cat userdata | wc | awk '{print $1}')
cat userdata | grep 'gender' | sort | uniq > swap 
cat swap > userdata
rm -f swap
searchstart &
wait
else 
echo "# 未找到 $1"
fi 
rmfiles
