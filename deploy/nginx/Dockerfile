FROM nginx:1.17-alpine

ENV USER=nginx

ARG RAILS_ENV

COPY --chown=$USER configs/nginx.conf /etc/nginx/nginx.conf
COPY configs/templates/$RAILS_ENV/default.conf /etc/nginx/conf.d/templates/default.conf
COPY --chown=$USER docker-entrypoint.sh /usr/local/bin/

RUN chown -R $USER:$USER /etc/nginx/conf.d && \
    chown -R $USER:$USER /var/cache/nginx && \
    chown -R $USER:$USER /var/log/nginx

USER $USER

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
