#!/usr/bin/env bash
docker rm $(docker stop $(docker ps -a -q --filter ancestor=owasp/zap2docker-stable --format="{{.ID}}"))

echo $2
sudo chmod -R a+rw $2
#containerId=$(docker run -u zap -p 4444:4444 -d owasp/zap2docker-stable zap.sh -daemon -port 4444 -host 127.0.0.1 -config api.disablekey=true -config scanner.attackOnStart=true -config view.mode=attack -config connection.dnsTtlSuccessfulQueries=-1 -config api.addrs.addr.name=.* -config api.addrs.addr.regex=true)
containerId=$(sudo docker run -v $2:/tmp -p 4444:4444 -d owasp/zap2docker-stable zap.sh -daemon -port 4444 -host 127.0.0.1 -config api.disablekey=true -config scanner.attackOnStart=true -config view.mode=attack -config connection.dnsTtlSuccessfulQueries=-1 -config api.addrs.addr.name=.* -config api.addrs.addr.regex=true)
echo $containerId
url=$1

docker exec $containerId zap-cli -p 4444 status -t 120 && docker exec $containerId zap-cli -p 4444 open-url $url
docker exec $containerId zap-cli -p 4444 spider $url
docker exec $containerId zap-cli -p 4444 active-scan -r $url
docker exec $containerId zap-cli -p 4444 alerts
sudo docker exec $containerId zap-cli -p 4444 report -o /tmp/owasp-scan.html --output-format html

separator=_________________________________________________________________________________________________________
printf "\n"
printf "$separator"
printf "OWASP log output:"
printf "$separator"
printf "\n"

docker logs $containerId

docker stop $containerId