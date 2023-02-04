url="https://sso.godaddy.com/v1/api/idp/recovery/password/?username=$1&app=dashboard.api"
cookie="uxp-ns=1; pathway=1; fb_sessiontraffic=1; visitor=1; market=1; currency=1; traffic=; _policy=1; akm_lmprb-ssn=1; akm_lmprb=1; tcc_refer=1"
ua="1"
curl -s -m 10 --retry 1024 "$url" -b "$cookie" -A "$ua" -o tmp_godaddy
echo "godaddy: $1 $(cat tmp_godaddy | sed -e 's/ /+/g' -e 's/{/ /g' -e 's/}/ /g' -e 's/,/ /g' -e 's/""/null/g' -e 's/"//g' | awk '{for(i=1;i<=NF;i++){print $i}}' | grep 'message' | sed -e 's/+/ /g' -e 's/message://g')" 
rm tmp_godaddy