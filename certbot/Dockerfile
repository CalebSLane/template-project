FROM certbot/certbot:v3.2.0 AS runtime

FROM runtime AS dev

#this container does not need to run for testcoverage
FROM runtime AS testcoverage
CMD [ "exit" ]

FROM runtime AS test

FROM runtime AS prod
RUN adduser -D certbot_user
USER certbot_user