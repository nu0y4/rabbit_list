#!/bin/bash
database64='eyJxdWVyeSI6IlxuICAgIHF1ZXJ5IHVzZXJQcm9maWxlUHVibGljUHJvZmlsZSgkdXNlclNsdWc6
IFN0cmluZyEpIHtcbiAgdXNlclByb2ZpbGVQdWJsaWNQcm9maWxlKHVzZXJTbHVnOiAkdXNlclNs
dWcpIHtcbiAgICAgcHJvZmlsZSB7XG4gICAgICB1c2VyU2x1Z1xuICAgICAgcmVhbE5hbWVcbiAg
ICAgIGFib3V0TWVcbiAgICAgIGFzY2lpQ29kZVxuICAgICAgIGdlbmRlclxuICAgICAgd2Vic2l0
ZXNcbiAgICAgIHNraWxsVGFnc1xuICAgICAgaXBSZWdpb25cbiAgICAgIGJpcnRoZGF5XG4gICAg
ICBsb2NhdGlvblxuICAgICAgdXNlRGVmYXVsdEF2YXRhclxuICAgICAgZ2l0aHViXG4gICAgICBz
Y2hvb2w6IHNjaG9vbFYyIHtcbiAgICAgICAgc2Nob29sSWRcbiAgICAgICAgbG9nb1xuICAgICAg
ICBuYW1lXG4gICAgICB9XG4gICAgICBjb21wYW55OiBjb21wYW55VjIge1xuICAgICAgICBpZFxu
ICAgICAgICBsb2dvXG4gICAgICAgIG5hbWVcbiAgICAgIH1cbiAgICAgIGpvYlxuICAgICAgZ2xv
YmFsTG9jYXRpb24ge1xuICAgICAgICBjb3VudHJ5XG4gICAgICAgIHByb3ZpbmNlXG4gICAgICAg
IGNpdHlcbiAgICAgICAgb3ZlcnNlYXNDaXR5XG4gICAgICB9XG4gICAgICBzb2NpYWxBY2NvdW50
cyB7XG4gICAgICAgIHByb3ZpZGVyXG4gICAgICAgIHByb2ZpbGVVcmxcbiAgICAgIH1cbiAgICAg
IHNraWxsU2V0IHtcbiAgICAgICAgbGFuZ0xldmVscyB7XG4gICAgICAgICAgbGFuZ05hbWVcbiAg
ICAgICAgICBsYW5nVmVyYm9zZU5hbWVcbiAgICAgICAgICBsZXZlbFxuICAgICAgICB9XG4gICAg
ICAgIHRvcGljcyB7XG4gICAgICAgICAgc2x1Z1xuICAgICAgICAgIG5hbWVcbiAgICAgICAgICB0
cmFuc2xhdGVkTmFtZVxuICAgICAgICB9XG4gICAgICAgIHRvcGljQXJlYVNjb3JlcyB7XG4gICAg
ICAgICAgc2NvcmVcbiAgICAgICAgICB0b3BpY0FyZWEge1xuICAgICAgICAgICAgbmFtZVxuICAg
ICAgICAgICAgc2x1Z1xuICAgICAgICAgIH1cbiAgICAgICAgfVxuICAgICAgfVxuICAgIH1cbiAg
ICBlZHVjYXRpb25SZWNvcmRMaXN0IHtcbiAgICAgIHVudmVyaWZpZWRPcmdhbml6YXRpb25OYW1l
XG4gICAgfVxuICAgIG9jY3VwYXRpb25SZWNvcmRMaXN0IHtcbiAgICAgIHVudmVyaWZpZWRPcmdh
bml6YXRpb25OYW1lXG4gICAgICBqb2JUaXRsZVxuICAgIH1cbiAgfVxufVxuICAgICIsInZhcmlh
YmxlcyI6eyJ1c2VyU2x1ZyI6ImtleXdvcmQifX0=
'
echo "$database64" | base64 -d > leetcode
data=$(cat leetcode | sed -e "s/keyword/$1/g") 
curl -s -H 'Host: leetcode.cn' -H 'Accept: */*' -H 'Accept-Language: zh-CN,zh;q=0.8,zh-TW;q=0.7,zh-HK;q=0.5,en-US;q=0.3,en;q=0.2' -H 'Accept-Encoding: gzip, deflate' -H 'Content-Type: application/json'  -d "$data"  'https://leetcode.cn/graphql/' -o leetcode_user
cat leetcode_user | sed -e 's/ /++__++/g' -e 's/,/ /g' -e 's/{/ /g' -e 's/}/ /g' -e 's/""/unkonwn/g' -e 's/"//g'  | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -E -i '^gender|^profileurl|^overseasCity|^city|^province|^country|^globalLocation|^job|^company|^school|^github|^location|^birthday|^ipRegion|^realName|^userSlug|^unverifiedOrganizationName|^http|\[http|^jobTitle' | sed -e 's/gender//g' -e 's/overseasCity/海外/g' -e 's/globalLocation/地理位置信息/g' -e 's/unverifiedOrganizationName/学校/g' -e 's/^/# /g'
rm -f leetcode_user leetcode
 
