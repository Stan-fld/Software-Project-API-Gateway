#!/bin/bash
MYSQL_USERNAME='271246'
MYSQL_PASSWORD='azertyuio12345678'
MYSQL_DATABASE='projetcesi_authentication_db'
MYSQL_HOST='mysql-projetcesi.alwaysdata.net'


mysql -h $MYSQL_HOST -u $MYSQL_USERNAME -p$MYSQL_PASSWORD $MYSQL_DATABASE < database.sql
