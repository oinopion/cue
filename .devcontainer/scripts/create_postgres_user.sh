#!/bin/bash
# This script creates a user named "cue" with password "cue" for use in the
# application. Use this user instead of the main "postgres" superuser.


# Unofficial Bash Strict Mode
set -euo pipefail
IFS=$'\n\t'

# When Postgres container starts, it creates a default user and a default
# database, which we're going to use here to create an app specific user. The
# values here should be derived from "db" section in docker-compose.yml
export DEFAULT_DATABASE_URL="postgres://postgres:postgres@db/postgres"
export APP_USER="cue"

psql $DEFAULT_DATABASE_URL << SQL
   DO
   \$do\$
   BEGIN
      IF EXISTS (
         SELECT FROM pg_catalog.pg_roles WHERE rolname = '${APP_USER}') THEN
         RAISE NOTICE 'Role "cue" already exists. Skipping.';
      ELSE
         CREATE ROLE ${APP_USER} CREATEDB LOGIN PASSWORD '${APP_USER}';
         RAISE INFO 'Role "${APP_USER}" successfully created.';
      END IF;
   END
   \$do\$;
SQL
