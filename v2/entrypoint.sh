#!/bin/bash
/etc/init.d/elasticsearch start
sleep 30
/opt/elasticsearch/bin/elasticsearch-users useradd investigator -p forensics -r superuser
exec /usr/local/bin/start.sh
