#! /bin/sh
set -e
if [ -z "${ROOT_VAULT_TOKEN}" ]; then
    echo "variable ROOT_VAULT_TOKEN is empty so program will exit now!"
    exit 0
fi

export VAULT_ADDR=${PRIVATE_VAULT_WEB_ADDRESS}
vault login ${ROOT_VAULT_TOKEN}
vault auth enable userpass || echo "userpass already exists"
vault write auth/userpass/users/${PROJECT_NAME}-user \
    password=${VAULT_PASSWORD} || echo "user already exists"
vault secrets enable -path ${SHARED_VAULT_PATH} -version 2 kv || echo "${SHARED_VAULT_PATH} already exists"
vault kv get -mount=${SHARED_VAULT_PATH} ${PROJECT_NAME} || \
    vault kv put -cas=0 -mount=${SHARED_VAULT_PATH} ${PROJECT_NAME} \
        spring.security.oauth2.client.registration.keycloak.client-secret=${BACKEND_CLIENT_SECRET} \
        BACKEND_CLIENT_SECRET=${BACKEND_CLIENT_SECRET} \
        POSTGRES_PASSWORD=${POSTGRES_PASSWORD} \
        KC_DB_PASSWORD=${KC_DB_PASSWORD} \
        KC_BOOTSTRAP_ADMIN_PASSWORD=${KC_BOOTSTRAP_ADMIN_PASSWORD}
vault policy write shared-access-policy /shared-policy || echo "policy already exists"
vault write auth/userpass/users/${PROJECT_NAME}-user \
    policies=shared-access-policy || echo "policy already applied to user"
vault token create -policy=shared-access-policy || echo "token already created"


# vault write cubbyhole/git-credentials username="student01" password="p@$$w0rd"# create key2 with type ecdsa-p256
