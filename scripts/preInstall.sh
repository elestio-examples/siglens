#set env vars
set -o allexport; source .env; set +o allexport;


mkdir -p ./storage

cat <<EOT > ./sample.sh
curl -L https://github.com/siglens/pub-datasets/releases/download/v1.0.0/2kevents.json.tar.gz -o 2kevents.json.tar.gz
tar -xvf 2kevents.json.tar.gz

for ((i=1; i<=20; i++))
do
    curl http://${DOMAIN}:48926/elastic/_bulk -i --data-binary "@2kevents.json" -o res.txt 
done
EOT