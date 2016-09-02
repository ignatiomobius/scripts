#!/bin/sh
DBNAME=$1
sudo -u moauser pg_dump -s $DBNAME > ${DBNAME}-schema.sql
sudo -u moauser pg_dump -a $DBNAME > ${DBNAME}-data.sql
