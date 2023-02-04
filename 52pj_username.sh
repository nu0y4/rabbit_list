#!/bin/bash
curl -s -H 'User-Agent: Mozilla/5.0 (X11; CrOS x86_64 14794.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/103.0.5045.0 Safari/537.36' "https://www.52pojie.cn/forum.php?mod=ajax&inajax=yes&infloat=register&handlekey=register&ajaxmenu=1&action=checkusername&username=$1" -o ./52pj
result=$(iconv -f gbk -t UTF-8 -c 52pj | grep '该用户名已注册')
test_result=${#result}
if [ $test_result != 0 ]
then 
echo "# 52pj $1 已注册"
else 
echo "# 52pj $1 未注册"
fi 
rm -f 52pj
