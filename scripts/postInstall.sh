#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 60s;

target=$(docker-compose port siglens 8081)

cat <<EOT > ./samples.sh
curl -L https://github.com/siglens/pub-datasets/releases/download/v1.0.0/2kevents.json.tar.gz -o 2kevents.json.tar.gz
tar -xvf 2kevents.json.tar.gz

for ((i=1; i<=20; i++))
do
    curl http://${target}/elastic/_bulk -i --data-binary "@2kevents.json" -o res.txt 
done
EOT

chmod +x ./sample.sh