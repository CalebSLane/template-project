#!/bin/sh
curl --silent \
    -H "X-Vault-Token: '${SHARED_VAULT_TOKEN}'" \
    -X GET \
    ${PRIVATE_VAULT_WEB_ADDRESS}/v1/${SHARED_VAULT_PATH}/data/${PROJECT_NAME} > /tmp/${PROJECT_NAME}
sed -E -i 's/.*"data":\{"data":\{(.*)\},"metadata".*/\1/g' /tmp/${PROJECT_NAME}
sed -E -i 's/,/\n/g' /tmp/${PROJECT_NAME}
sed -E -i 's/[-\."]//g' /tmp/${PROJECT_NAME}
sed -E -i 's/:/="/g' /tmp/${PROJECT_NAME}
sed -E -i 's/(.+)/\1"/g' /tmp/${PROJECT_NAME}
set -a 
source /tmp/${PROJECT_NAME}
set +a
rm /tmp/${PROJECT_NAME}

/usr/local/bin/docker-entrypoint.sh "$@"