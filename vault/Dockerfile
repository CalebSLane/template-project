FROM hashicorp/vault:1.18.4 AS runtime
RUN adduser -D vault_user 
RUN addgroup vault_group
RUN apk add --no-cache curl 
EXPOSE 8080
CMD [ "vault", "server", "-config=/vault/config/vault-config.json" ]
# USER vault_user 

FROM runtime AS dev

#this container does not need to run for testcoverage
FROM runtime AS testcoverage
CMD [ ]
ENTRYPOINT ["tail", "-f", "/dev/null"]

FROM runtime AS staging

FROM runtime AS prod

