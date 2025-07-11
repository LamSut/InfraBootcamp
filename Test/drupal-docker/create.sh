if ! sudo grep -q "limdrupal.local" /etc/hosts; then
    echo "127.0.0.1 limdrupal.local" | sudo tee -a /etc/hosts > /dev/null
fi

mkdir -p certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout certs/privkey.pem \
  -out certs/fullchain.pem \
  -subj "/C=VN/ST=CT/L=CT/O=BE/OU=BECT/CN=limdrupal.local"s

docker compose up -d


