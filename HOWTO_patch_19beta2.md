### With tar ball ...

````
wget https://www.postgresql.org/ftp/source/v19beta2/
gunzip postgresql-19beta2.tar.gz 
tar xf postgresql-19beta2.tar 
cd postgresql-19beta2/
git init
git add  .
git commit -m "Initial untar of v19beta2 source"
````
... build postgres ...

````
git add ./src/backend/parser/gram.y
git commit -m "bug#19558: Fix user-defined prefix operators '|' and '->'"
git format-patch -1 HEAD
````
patch is:
````001-bug-19558-Fix-user-defined-prefix-operators-and.patch````

### ... or use branch REL_19_BETA2 from https://git.postgresql.org/gitweb/?p=postgresql.git;a=summary (not available in github.com/postgres)
