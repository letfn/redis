FROM redis:6.0.9 AS redis

FROM letfn/python

USER app

COPY --from=redis /usr/local/bin/redis* /usr/local/bin/

COPY service /service

ENTRYPOINT [ "/tini", "--", "/service" ]

CMD [ "/etc/redis.conf" ]
