# -- expected to be `source`ed

: ${SELFSIGNED_CURVE:=secp384r1}
: ${SELFSIGNED_DAYS:=365}
: ${SELFSIGNED_SUBJECT:=/}

if [ -f /data/nginx-ssl/selfsigned.key ]; then
  debug ssl Using self-signed certificate in /data/nginx-ssl
else
  info ssl Generating EC-$SELFSIGNED_CURVE key and a self-signed certificate to /data/nginx-ssl
  mkdir -p /data/nginx-ssl
  openssl req -x509 -nodes -subj "$SELFSIGNED_SUBJECT" \
    -days $SELFSIGNED_DAYS -newkey ec:<(openssl ecparam -name $SELFSIGNED_CURVE) \
    -keyout /data/nginx-ssl/selfsigned.key -out /data/nginx-ssl/selfsigned.crt \
    > /dev/null 2>&1 || error nginx Key generation failed
fi
