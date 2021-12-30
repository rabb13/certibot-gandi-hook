# certbot hook gandi

Simple gandi api v5 hook for Certbot certificate

## Usage
CLI:
```
GANDI_API_KEY="my_gandi_api_key" certbot certonly \
 --manual --manual-auth-hook gandi.hook \
 --manual-cleanup-hook gandi_clean.hook \
 --preferred-challenges=dns \
 --email me@example.com \
 --server https://acme-v02.api.letsencrypt.org/directory \
 --agree-tos \
 -d example.com -d *.example.com
```

Optionally update the variables in run.sh:
```
./run.sh
```

Cron example:

```
0 1 * * * /path/to/run.sh
```
