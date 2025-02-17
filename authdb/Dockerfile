FROM postgres:17.3-alpine3.21 AS runtime
RUN mkdir temp
RUN adduser -D authdb_user 
RUN chown -R authdb_user /temp
RUN chmod 777 /temp
RUN sh -c | chown -R authdb_user /var/lib/postgresql/data
USER authdb_user

FROM runtime AS dev

#this container does not need to run for testcoverage
FROM runtime AS testcoverage
CMD [ "exit" ]

FROM runtime AS test

FROM runtime AS prod

