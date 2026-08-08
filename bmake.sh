#!/bin/bash
#
# bmake.sh
#
# build PG from source with postgres account
# with make
#
#
# -----------------------------------------------
export PGDATA=/var/lib/pgsql/data
export TARGET=/var/lib/pgsql/local
set -x
#
make clean
 ./configure --prefix=$TARGET --enable-debug --with-uuid=e2fs --with-openssl --enable-tap-tests
make -j
make check
#
rm -rf $TARGET
mkdir $TARGET 
make install
#
export PATH=$TARGET/bin:$PATH
#
pg_ctl stop
rm -rf $PGDATA
initdb 
pg_ctl -D $PGDATA -l logfile start
