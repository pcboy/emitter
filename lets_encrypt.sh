#!/bin/sh
if [ $LETSENCRYPT_DOMAIN ];then
  /root/.acme.sh/acme.sh --issue --standalone -d $LETSENCRYPT_DOMAIN
  /root/.acme.sh/acme.sh --install-cert -d  $LETSENCRYPT_DOMAIN --key-file $EMITTER_TLS_PRIVATE  --cert-file $EMITTER_TLS_CERTIFICATE # --reloadcmd ""
  cd /go/src/github.com/emitter-io/emitter/ && go-wrapper run
fi
