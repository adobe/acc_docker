#!/bin/bash
export LC_ALL='C'
export LANGUAGE='C'
DATABASE='neolane_db'

# uncomment if PSQL fails to connect
# eval $(/usr/sbin/camp-db-params -e)

echo "RUNNING QUERIES"
# older version of PG (ex: 9.0)
# psql -P pager=off -P format=wrapped -d "$DATABASE" -c "SELECT datname, procpid, now() - pg_stat_activity.query_start AS duration, current_query, client_addr, client_port FROM pg_stat_activity WHERE current_query != '<IDLE>'"
# recent version of PG
psql -P pager=off -P format=wrapped -d "$DATABASE" -c "SELECT pid, now() - pg_stat_activity.query_start AS duration, query, state, client_addr, client_port FROM pg_stat_activity WHERE state != 'idle'"

echo "DB SIZE"
psql -P pager=off -P format=wrapped -d "$DATABASE" -c "\l+"

echo "DISK SPACE"
df -h

echo "MEMORY"
free -m