#!/bin/sh
curl --silent \
    -H "X-Vault-Token: ${SHARED_VAULT_TOKEN}" \
    -X GET \
    ${PRIVATE_VAULT_WEB_ADDRESS}/v1/${SHARED_VAULT_PATH}/data/${PROJECT_NAME} > /tmp/uploads/${PROJECT_NAME}
sed -E -i 's/.*"data":\{"data":\{(.*)\},"metadata".*/\1/g' /tmp/uploads/${PROJECT_NAME}
sed -E -i 's/,/\n/g' /tmp/uploads/${PROJECT_NAME}
sed -E -i 's/[-\."]//g' /tmp/uploads/${PROJECT_NAME}
sed -E -i 's/:/="/g' /tmp/uploads/${PROJECT_NAME}
sed -E -i 's/(.+)/\1"/g' /tmp/uploads/${PROJECT_NAME}
set -a 
source /tmp/uploads/${PROJECT_NAME}
set +a
rm /tmp/uploads/${PROJECT_NAME}

/opt/keycloak/bin/kc.sh "$@"