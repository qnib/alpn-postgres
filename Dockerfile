FROM qnib/alpn-consul

ENV PGDATA=/var/lib/pgsql/data/
RUN apk add --update postgresql \
 && mkdir -p /var/lib/pgsql/data/ \
 && chown postgres: /var/lib/pgsql/data \
 && su -l -c "pg_ctl -c initdb -D /var/lib/pgsql/data/" postgres
ADD var/lib/pgsql/data/pg_hba.conf \
    var/lib/pgsql/data/postgresql.conf \
    /var/lib/pgsql/data/
ADD etc/consul.d/postgres.json /etc/consul.d/
ADD etc/supervisord.d/postgres.ini /etc/supervisord.d/
