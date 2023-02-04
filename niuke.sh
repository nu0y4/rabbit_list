#!/bin/bash
max_page=2
max_number=10

function main()
{ 
curl -s -H 'Content-Type: application/json' -H 'Accept: application/json, text/plain, */*' --data-binary "{\"query\": \"$1\",\"type\":\"user\",\"page\":1,\"pageSize\":15}" 'https://gw-c.nowcoder.com/api/sparta/pc/search?_=1' -o niuke_1
totalpage=$(cat ./niuke_1 | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | sed -e 's/"//g' | grep 'totalPage' | sed -e 's/totalPage://g')
echo "totalpage=$totalpage"
cat niuke_1 | sed -e 's/ /+_+/g' -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -E 'workTime|educationInfo|userId|identityList|nickname' | xargs | sed -e 's/ /,/g' -e 's/}/ /g' -e 's/userId/ userId/g' | awk '{for(i=1;i<=NF;i++){print $i}}' > niuke_all
rm niuke_1
for page in `seq 2 $totalpage`
do 
if [ $page == $max_page ]
then 
echo "# 达到最大页数"
break
fi 
curl -s -H 'Content-Type: application/json' -H 'Accept: application/json, text/plain, */*' --data-binary "{\"query\": \"$1\",\"type\":\"user\",\"page\":$page,\"pageSize\":15}" 'https://gw-c.nowcoder.com/api/sparta/pc/search?_=1' -o niuke_1
cat ./niuke_$page | sed -e 's/ /+_+/g' -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -E 'workTime|educationInfo|userId|identityList|nickname' | xargs | sed -e 's/ /,/g' -e 's/}/ /g' -e 's/userId/ userId/g' | awk '{for(i=1;i<=NF;i++){print $i}}' >> niuke_all
done 
}
main $1
echo "# 开始获取详细数据"
function getmore()
{
for try in `seq 1 3`
do 
for line in $(cat ./niuke_all | grep -i -v 'jobname')
do 
{
# echo "userid=$userid"
userid=$(echo "$line" | sed -e 's/,/ /g' -e 's/:/ /g' | awk '{print $2}' )
test_userid=${#userid}
if [ $test_userid != 0 ]
then 
curl -s -m 5 --retry 1024 "https://www.nowcoder.com/users/$userid" -o ./niuke_$userid &
wait 
dir=$(ls | grep "niuke_$userid")
test_dir=${#dir}
if [ $test_dir != 0 ]
then 
addup=$(cat ./niuke_$userid | grep '"profile":' | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | sed -e 's/""/null/g' -e 's/"//g' | grep -E '^additionInfoCompleteRate:|^jobName|^schoolMajor|^eduLevel|^ip4Location|^identityList|^livePlace|^memberIdentity' | xargs |  sed -e 's/ /,/g' -e 's/,,/,/g' )
sed -e "s/$line/$line$addup/g" -i ./niuke_all
fi
rm -f ./niuke_$userid
fi 
} &
done
wait 
done 
}
wait
getmore
cat niuke_all | sed -e 's/workTime/工作时间/g' -e 's/educationInfo/学校信息/g' -e 's/jobName/工作内容/g' -e 's/schoolMajor/主修专业/g' -e 's/eduLevel/学位/g' -e 's/additionInfoCompleteRate/资料完善度/g' -e 's/ip4Location/属地/g' -e 's/+_+/ /g' > result 
line=$(cat ./result | wc | awk '{print $1}')
if [ $line == 1 ]
then 
cat result | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | sed -e 's/^/# /g'
else 
cat result | sed -e 's/^/# /g'
fi 
rm -f niuke_all ./result




