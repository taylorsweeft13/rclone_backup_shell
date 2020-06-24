#!/bin/bash
docker stop bitwarden
echo '1	stop bitwarden success'

docker rm bitwarden
echo '2	rm bitwarden success'

docker pull bitwardenrs/server:latest
echo '3	pull bitwarden success'

docker run -d --name bitwarden\
    --restart=always \
    -v /file/bw-data/:/data/ \
    -e ADMIN_TOKEN=0 \
    -e SIGNUPS_ALLOWED=false \
    -e WEBSOCKET_ENABLED=true \
    -e LOG_FILE=/data/bitwarden.log \
    -e DOMAIN=https://xxxxx\
    -p 3080:80 \
    -p 3012:3012 \
bitwardenrs/server:latest

echo '4	delete unuse images'	
docker images | grep none | grep -v grep | awk '{print $3}' | xargs  docker rmi -f

echo '5	run bitwarden success'
