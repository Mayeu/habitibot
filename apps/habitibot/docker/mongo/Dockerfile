FROM mongo

RUN mkdir -p /var/db/mongodump
COPY habitrpg /var/db/mongodump/habitrpg
COPY restore-script.sh /docker-entrypoint-initdb.d/restore-script.sh
RUN chmod -R ugo+x /docker-entrypoint-initdb.d/restore-script.sh
