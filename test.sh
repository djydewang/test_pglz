#!/usr/bin/env bash

set -e
pkill -9 postgres || true
make install

DB=~/DemoDb1
BINDIR=~/db_install/postgres/bin

rm -rf $DB
cp *.sql $BINDIR
cd $BINDIR
./initdb $DB
./pg_ctl -D $DB start
./psql postgres -c "create extension test_pglz;"

./psql postgres -c "select test_pglz();"

./pg_ctl -D $DB stop
