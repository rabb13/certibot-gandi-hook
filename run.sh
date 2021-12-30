#!/bin/env bash
# Simple example to create or renew wirlcard cert includig root domain
# Apply when expiry is within the value RENEW_BEFORE_DAYS

GANDI_DOMAIN="example.com"
CHECK_DOMAIN="example.com"
GANDI_EMAL="someone@example.com"
RENEW_BEFORE_DAYS="30"

export GANDI_API_KEY="MyKey"

SCRIPT_DIR=$(dirname "$0")

# Check expiry
date_now=$(date -d now +%s)
date_exp=$(date -d "$(timeout 3 openssl s_client -servername ${GANDI_DOMAIN} -connect ${CHECK_DOMAIN}:443 2> /dev/null | openssl x509 -noout -enddate | grep -i notAfter | sed s/notAfter=//) " +%s)
date_diff=$(( (date_exp - date_now) / 86400 ))

if [ $date_diff -le $RENEW_BEFORE_DAYS ]; then
  certbot certonly -n --manual --manual-auth-hook ${SCRIPT_DIR}/gandi.hook --manual-cleanup-hook ${SCRIPT_DIR}gandi_clean.hook --preferred-challenges=dns --email ${GANDI_EMAL} --server https://acme-v02.api.letsencrypt.org/directory --agree-tos -d ${GANDI_DOMAIN} -d *.${GANDI_DOMAIN}
fi

# Certbot will not renew cert if its new anyway
