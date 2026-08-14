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
 ./configure --prefix=$TARGET --enable-cassert --enable-debug --with-uuid=e2fs --with-openssl --enable-tap-tests
make -j
make check
#
rm -rf $TARGET
mkdir $TARGET 
make install
#
# must build and install contrib extensions for 'make installcheck-world'
#
cd contrib
make
make install
#
# must be run for make 'installcheck-world'
# 
cd ..
make -C src/test/modules/test_extensions install
#
export PATH=$TARGET/bin:$PATH
#
pg_ctl stop
rm -rf $PGDATA
initdb 
#
echo "logging_collector = on" > $PGDATA/mypg.conf
echo "log_directory = 'log'" >> $PGDATA/mypg.conf
echo "log_filename = 'pg.log'" >> $PGDATA/mypg.conf
echo "include = 'mypg.conf'" >> $PGDATA/postgresql.conf
#
pg_ctl -D $PGDATA -l logfile start
