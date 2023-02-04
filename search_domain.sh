rm -f result
for dingji in $(cat top | sed -e 's/\.//g')
do
{
site="$1"."$dingji"
result="$(host "$site" | awk '{for(i=1;i<=NF;i++){print $i}}' | grep -v -E "$site|found:|192\.168\.|127\.0\.0|0\.0\.0\.0|mismatch:|Warning:" | grep -E ':|\.' | sort | uniq | xargs )" 
test_result=${#result}
if [ $test_result != 0 ]
then 
echo "# $site: $result"
fi 
} &
done
wait

