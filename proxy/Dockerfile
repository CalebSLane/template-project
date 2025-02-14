FROM nginx:1.27.4-alpine-slim AS runtime
RUN apk add --no-cache curl 
#removing user directive since we're running the container as non-root
RUN sed -i 's,user  nginx;,,' /etc/nginx/nginx.conf
#this allows us to mount just the pid file as a tmpfs that is writeable 
RUN sed -i 's,/var/run/nginx.pid,/var/run/nginx/nginx.pid,' /etc/nginx/nginx.conf
#this allows us to run the container as a non-root user with fewer capabilities by using non-privileged ports
EXPOSE 8080 8443
USER nginx
CMD ["nginx", "-g", "daemon off;"]

FROM runtime AS dev

#this container does not need to run for testcoverage
FROM runtime AS testcoverage
CMD [ "exit" ]

FROM runtime AS test

FROM runtime AS prod

