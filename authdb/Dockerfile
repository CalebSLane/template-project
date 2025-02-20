FROM postgres:17.3-alpine3.21 AS runtime
COPY ./authdb-entrypoint.sh /authdb-entrypoint.sh
RUN apk add --no-cache curl 
RUN mkdir temp
RUN adduser -D authdb_user 
RUN addgroup authdb_group
RUN chown -R authdb_user:authdb_group /authdb-entrypoint.sh
RUN chown -R authdb_user:authdb_group /temp
RUN chmod 777 /temp
RUN sh -c | chown -R authdb_user:authdb_group /var/lib/postgresql/data
USER authdb_user
ENTRYPOINT ["/authdb-entrypoint.sh"]
CMD ["postgres"]

FROM runtime AS dev

#this container does not need to run for testcoverage
FROM runtime AS testcoverage
CMD [ "exit" ]

FROM runtime AS test

FROM runtime AS prod

