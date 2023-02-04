#!/bin/bash
cat ./bak/log | sed -e 's/,/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep 'ip:' | sed -e 's/:/ /g' | awk '{print $2}' | sort | uniq > ./bak/iplist_test
cat ./bak/iplist | sed -e 's/,/ /g' | awk '{print $1}' | sort | uniq  > ./bak/iplist_old
cat ./bak/iplist_old ./bak/iplist_test | sort | uniq -u  >> ./bak/iplist
rm ./bak/iplist_old ./bak/iplist_test
function getconfig()
{
cat ./config | grep -v '^#' | grep "$1" | sed -e 's/=/ /g' | awk '{print $2}'
}
ip_api_sleep=$(getconfig ip_location_sleep)
for ip in $(cat ./bak/iplist | grep -v 'city:')
do 
{
# ip 定位脚本，返回数据 包含 位置信息字符串,经,纬度,顺序任意 
# 免费api 原文连接 https://zhuanlan.zhihu.com/p/170621813
ip_location="$(./free_ip.sh $ip)" 
# 格式 经度:value,纬度:value,...参数:value
# 特别注意 经度 使用 lat 参数，纬度使用 lon参数
sed -e "s/$ip/$ip,$ip_location/g" -i ./bak/iplist 
sleep $ip_api_sleep  
# 替换这部分为你自己的定位api就好了，比如站长之家的，或者ipip的，纯真api等等
} 
done
