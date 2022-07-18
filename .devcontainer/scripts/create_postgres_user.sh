#!/bin/bash
# This script creates a user named "cue" with password "cue" for use in the
# application. Use this user instead of the main "postgres" superuser.


# Unofficial Bash Strict Mode
set -euo pipefail
IFS=$'\n\t'

export APP_USER="cue"

export PGUSER="postgres"      # default postgres superuser
export PGPASSWORD="postgres"  # ... and password
export PGHOST="db"            # name of the postgres container

psql << SQL
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
