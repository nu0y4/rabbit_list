curl -s --retry 10 "https://api.genderize.io/?name=$1" -o test1
curl -s --retry 10 "https://api.agify.io/?name=$1" -o test2 
curl -s --retry 10 "https://api.nationalize.io/?name=$1" -o test3
cat ./test1 ./test2 ./test3 > ./log
cat ./log | sed -e 's/{/ /g' -e 's/,/ /g' -e 's/}/ /g' -e 's/\[/ /g' -e 's/\]/ /g' | awk '{for(i=1;i<=NF;i++){print $i}}' | sed -e 's/"//g' -e 's/probability/#  可能性 /g'  -e 's/gender/#  性别/g' -e 's/name/#  名字/g' -e 's/age/#  年龄/g' -e 's/country/#  国家/g' -e 's/count/#  样本数量/g' -e 's/_id/代码/g' 
rm -f ./test1 ./test2 ./test3 ./log