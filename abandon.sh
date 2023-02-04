#!/bin/bash
function weijin()
{
curl -s -m 5 --retry 1024 "https://v.api.aa1.cn/api/api-mgc/index.php?msg=$1" -o minggan
result=$(cat minggan | grep '存在敏感词')
test_result=${#result}
if [ $test_result != 0 ]
then 
echo "# 存在违禁"
else
echo "# 未发现违规"
fi 
rm minggan
}
weijin $1