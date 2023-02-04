name="$1"
url="https://ipv6.he.net/certification/register.php?ajax=true"
cookie="referer=Direct+Access; PHPSESSID=0; _gcl_au=1"
post="field=user_name&value=$name"
curl "$url" -b "$cookie" -d "$post" -s -m 3 --retry 1024 -o tmp_ipv6he
result="$(cat tmp_ipv6he )"
if [ -z "$result" ]
then
echo "$name:未注册"
else 
echo "$name:已注册"
fi
rm -f tmp_ipv6he