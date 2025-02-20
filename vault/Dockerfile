FROM hashicorp/vault:1.18.4 AS runtime
RUN adduser -D vault_user 
RUN addgroup vault_group
RUN apk add --no-cache curl 
# USER vault_user 

FROM runtime AS dev

#this container does not need to run for testcoverage
FROM runtime AS testcoverage
CMD [ "exit" ]

FROM runtime AS test

FROM runtime AS prod

