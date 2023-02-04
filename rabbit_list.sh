#!/bin/bash
if [ $# == 0 ]
then 
echo "# eg: ./stalin_list.sh --help"
echo "# show help tags"
exit
fi
function printlogo()
{
echo -e "
薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇
薇薇薇薇　　　　　薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇
薇薇　　　　　　　　薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇
薇薇　　　薇薇　　　　薇薇薇　　　薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇
薇薇　　　薇薇　　　　薇薇薇　　　薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇
薇薇　　　薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇
薇薇　　　　薇薇薇薇薇　　　　　　　　　薇薇薇薇　　　　　　薇薇薇薇薇薇　　　薇薇薇薇薇薇薇　　　薇薇薇薇　　　　　　　　　薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇　　　　　　　薇薇　　　　　　　　　薇薇
薇薇薇　　　　　　薇薇薇薇薇　　　薇薇薇薇薇薇　　　薇薇　　　薇薇薇薇薇　　　薇薇薇薇薇薇薇　　　薇薇薇薇　　　　　薇　　　薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇　　　薇薇　　　薇薇薇薇　　　薇薇薇薇薇
薇薇薇薇薇　　　　　薇薇薇薇　　　薇薇薇薇薇薇　薇薇薇薇　　　薇薇薇薇薇　　　薇薇薇薇薇薇薇　　　薇薇薇薇　　　　薇薇　　　薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇　　　薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇
薇薇薇薇薇薇薇　　　　薇薇薇　　　薇薇薇薇薇薇薇薇薇　　　　　薇薇薇薇薇　　　薇薇薇薇薇薇薇　　　薇薇薇薇　　　薇薇薇　　　薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇　　　　　薇薇薇薇薇薇薇　　　薇薇薇薇薇
薇　　　　薇薇薇　　　薇薇薇　　　薇薇薇薇薇薇　　　　　　　　薇薇薇薇薇　　　薇薇薇薇薇薇薇　　　薇薇薇薇　　　薇薇薇　　　薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇薇　　　　　　薇薇薇薇薇　　　薇薇薇薇薇
薇　　　　薇薇薇　　　薇薇薇　　　薇薇薇薇薇　　　薇薇薇　　　薇薇薇薇薇　　　薇薇薇薇薇薇薇　　　薇薇薇薇　　　薇薇薇　　　薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇　　　薇薇薇薇薇
薇薇　　　薇薇　　　　薇薇薇　　　薇薇薇薇薇　　　薇薇　　　　薇薇薇薇薇　　　薇薇薇薇薇薇薇　　　薇薇薇薇　　　薇薇薇　　　薇薇薇薇　　　薇薇薇薇薇薇薇薇薇薇　　　薇薇薇薇　　　薇薇薇　　　薇薇薇薇　　　薇薇薇薇薇
薇薇　　　　　　　　薇薇薇薇薇　　　　　　薇　　　　　　　　　薇薇薇薇薇　　　薇薇薇薇薇薇薇　　　薇薇薇薇　　　薇薇薇　　　薇薇薇薇　　　　　　　　　薇薇薇薇　　　薇薇薇薇薇　　　　　　　　薇薇薇薇　　　　　　　薇
薇薇薇薇　　　　　薇薇薇薇薇薇薇　　　　　薇薇薇　　　　　　　　薇薇薇薇　　　薇薇薇薇薇薇薇　　　薇薇薇薇　　　薇薇薇　　　薇薇薇薇　　　　　　　　　薇薇薇薇　　　薇薇薇薇薇薇　　　　　薇薇薇薇薇薇薇　　　　　薇薇
薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇薇"
}
# printlogo
all=$(echo "$@" | awk '{for(i=1;i<=NF;i++){print $i}}')
front=null
for words in $all
do
if [ $words == '--help' ]
then 
echo "# stalin_list version 1 "
echo "# author: lidazhi"
echo "# OSINT && Infomation Gather && Hacker Geolocation Information Mapping && what's more.."
echo ""
echo "# --add_list"
echo "# eg: --add_list lvdouzhou"
echo "# useage: add a new keywords in stalin list"
echo ""
echo "# --del_list"
echo "# eg: --del_list lvdouzhou"
echo "# useage: del a keyword from list"
echo ""
echo "# --show_list"
echo "# eg: --show_list"
echo "# useage: show the list that this program had set"
echo ""
echo "# --chase"
echo "# eg: --chase username"
echo "# useage: search a keyword by stalin_list"
echo ""
echo "# --file_list"
echo "# eg: --file_list ./bak/log"
echo "# useage: set a file to save data that stalin_list had find,you don't have to set this if you don't need it"
echo ""
echo "# --find"
echo "# eg: --find lidazhi,1.1.1.1,男"
echo "# useage: search from local file ./bak/log,keywords may be username,nickname,gender,email,position,school,company"
# echo ""
# echo "# --rank"
# echo "# eg: --rank lat:29.56278,lon:106.55278,rank:1000"
# echo "# useage: Set a latitude and longitude and range, look for the IPs contained in it and the information that is logged"
# echo "# careful: this funcation need a Expensive API that offer you Accurate IP location,you have to code a script your self,or it won't work"
# echo "# for more infomation to setup your own ip to location mode,please read ./config"
echo ""
echo "# --seek"
echo "# eg: --seek-username lidazhi"
echo "# useage: most of this mode are free! but some of this mode need api to work,check ./config to blank your own apikey"
echo "# --seek username:lidezhi will Crawling many site that Chinaese developer and hacker often use,infomation base on keyword username,you have to cheek it yourself"
echo ""
# echo "# eg: --seek email:lidazhi@qq.com"
# echo "# useage: this mode are also use crawer to get infomation about this email"
# echo ""
# echo "# eg: --seek phone:188******9"
# echo "# useage: this mode cloud find many infomation about phone user,may be leak qq number,weibo id,may be somebody who had also searched this numer,or what website it reged"
# echo "# for more site reg infomation click http://www.newx007.com/r/074063FE1295C842713F75B501A29458 to find more(they don't share api,but I think they are best in China)"
# echo ""
# echo "# eg: --seek ip:1.1.1.1"
# echo "# useage:find ip infomations on zoomeye,fofa,xthreatbook,may contains Threat intelligence,IP assets,domain infomation.."
# echo "# for more threat intelligence in China,you should try https://x.treatbook.com/"
# echo ""
# echo "# eg: --seek domain:qq.com"
# echo "# useage: find emails reletive to this domain,find ip,treat intelligence,register infomation,domain Record,urls..."
exit
elif [ $front == '--find' ]
then 
./search.sh $words
elif [ $front == '--del_list' ]
then 
sed -e "s/$words//g" -i ./list
sed '/^[[:space:]]*$/d' -i ./list
elif [ $front == '--add_list' ]
then 
echo "$words" >> ./list
echo "# 成功将 $words 添加到监测名单"
echo "# 共 $(cat ./list | wc | awk '{print $1}') 条记录"
elif [ $words == '--show_list' ]
then
echo "#"
echo "# 监视名单" 
cat ./list | sed -e 's/^/# /g'
line=$(cat ./list | wc | awk '{print $1}')
echo "#"
echo "# 记录ip"
cat ./bak/iplist | sed -e 's/^/# /g'
line1=$(cat ./bak/iplist | wc | awk '{print $1}')
echo "#"
echo "# 共监视 $line 个 关键词,共 $line1 个 ip 记录"
elif [ $front == '--seek-username' ]
then 
username=$words
./username.sh $username
fi 
front=$words
done 
