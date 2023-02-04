#!/bin/bash
command=$(echo "Y3VybCAtcyAtbSA1IC0tcmV0cnkgMTAyNCAgLVggJCdQT1NUJyAgLUggJCdIb3N0OiBhY2NvdW50LmNuYmxvZ3MuY29tJyAtSCAkJ0FjY2VwdDogYXBwbGljYXRpb24vanNvbiwgdGV4dC9wbGFpbiwgKi8qJyAtSCAkJ0FjY2VwdC1MYW5ndWFnZTogemgtQ04semg7cT0wLjgsemgtVFc7cT0wLjcsemgtSEs7cT0wLjUsZW4tVVM7cT0wLjMsZW47cT0wLjInIC1IICQnQWNjZXB0LUVuY29kaW5nOiBnemlwLCBkZWZsYXRlJyAtSCAkJ1gtUmVxdWVzdGVkLVdpdGg6IFhNTEh0dHBSZXF1ZXN0JyAtSCAkJ0NvbnRlbnQtVHlwZTogbXVsdGlwYXJ0L2Zvcm0tZGF0YTsgYm91bmRhcnk9LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tMScgIC0tZGF0YS1iaW5hcnkgJCctLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTFceDBkXHgwYUNvbnRlbnQtRGlzcG9zaXRpb246IGZvcm0tZGF0YTsgbmFtZT1cImRpc3BsYXlOYW1lXCJceDBkXHgwYVx4MGRceDBha2V5d29yZFx4MGRceDBhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0xLS1ceDBkXHgwYScgICQnaHR0cHM6Ly9hY2NvdW50LmNuYmxvZ3MuY29tL2FjY291bnQvY2hlY2tEaXNwbGF5TmFtZSc=" | base64 -d | sed -e "s/keyword/$1/g")
echo "#!/bin/bash" > 1.sh
echo "$command" >> 1.sh 
chmod +x ./1.sh
result=$(./1.sh | sed -e 's/"//g')
# echo "result=$result"
if [ $result == '\u663E\u793A\u6635\u79F0\u5DF2\u88AB\u4F7F\u7528' ]
then 
echo "cnblog $1 已注册"
# 找回密码
else 
echo "cnblog $1 未注册"
fi 
rm ./1.sh