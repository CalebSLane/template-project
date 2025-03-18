FROM certbot/certbot:v3.2.0 AS runtime
RUN adduser -D certbot_user
RUN addgroup certbot_group

FROM runtime AS dev

#this container does not need to run for testcoverage
FROM runtime AS testcoverage
CMD [ ]
ENTRYPOINT ["tail", "-f", "/dev/null"]

FROM runtime AS staging

FROM runtime AS prod
USER certbot_user